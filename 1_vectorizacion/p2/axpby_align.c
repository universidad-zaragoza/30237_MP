/*
 *  The output includes several columns:
 *	Loop:		name of the loop
 *	Time(ns): 	time in nanoseconds to run the loop
 *	ps/el: 	  picoseconds per vector element
 *	Checksum:	checksum calculated when the test has run
 */

#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <malloc.h>
#include <string.h>
#include <x86intrin.h>

#include "precision.h"

// Los vectores deben caber en la cache para que la velocidad de ejecución
// no esté limitada por el ancho de banda de memoria principal
#ifndef LEN 
    #define LEN     (unsigned int) 1024
#endif
#define FLOP_IT    (unsigned long int)  3     /* 3 FLOP per iteration */

// Numero total de FLOP
// Si es múltiplo de LEN y FLOP_IT se facilitan las cuentas */
#define FLOP_COUNT  (unsigned long int) 3*4*5*512*1024*1024
// este valor de FLOP_COUNT es múltiplo para las siguientes combinaciones de LEN y FLOP_IT
//   LEN={ 1k, 2k, 4k, ... 1M, 2M, ... 512M }
//   FLOP_IT={ 1, 2, 3, 4, 5, 6 }

// para ejecuciones más rapidas con SDE */
// #define FLOP_COUNT  (unsigned long int) 3*4*5*1024*1024
#ifndef NTIMES
    #define NTIMES      (unsigned long int) (FLOP_COUNT/(LEN*FLOP_IT))    /* iteraciones bucle externo */
#endif

#define SIMD_ALIGN  64  /* 512 bits (preparado para AVX-512) */

/* LEN+1 porque hay recorridos que se inician en el elemento 1 */
static real x[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real y[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real alpha = 0.4;
static real beta = 0.6;

int dummy(real a[], real b[], real c[], real alpha, real beta);

/* inhibimos el inlining de algunas funciones
 * para que el ensamblador sea más cómodo de leer */

/* return wall time in seconds */
__attribute__ ((noinline))
double
get_wall_time()
{
    struct timeval time;
    if (gettimeofday(&time,NULL)) {
        exit(-1); // return 0;
    }
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
}

/* inhibimos vectorización en esta función
 * para que los informes de compilación sean más cómodos de leer */
#ifndef __INTEL_LLVM_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
void check(const real arr[LEN])
{
  real sum = 0;
#ifdef __INTEL_LLVM_COMPILER
  #pragma novector
#endif
  for (unsigned int i = 0; i < LEN+1; i++)
    sum += arr[i];

  printf("%f \n", sum);
}

#ifndef __INTEL_LLVM_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
int init()
{
#ifdef __INTEL_LLVM_COMPILER
  #pragma novector
#endif
    for (unsigned int j = 0; j < LEN+1; j++)
    {
	    x[j] = 2.0;
	    y[j] = 0.5;
    }
    return 0;
}

__attribute__ ((noinline))
void results(const double wall_time, const char *loop)
{
    printf("%19s  %6.1f    %6.1f     ",
            loop /* loop name */,
            wall_time/(1e-9*NTIMES),     /* ns/loop */
            wall_time/(1e-12*NTIMES*LEN) /* ps/el */);
}

/* v1: y[i  ] = alpha*x[i  ] + beta*y[i  ];
 * v2: y[i+1] = alpha*x[i+1] + beta*y[i+1];
 * v3: y[i  ] = alpha*x[i+1] + beta*y[i  ];
 * v4: y[i+1] = alpha*x[i  ] + beta*y[i+1];
 * v5: y[i  ] = alpha*x[i  ] + beta*y[i+1];
 * v6: y[i  ] = alpha*x[i+1] + beta*y[i+1];
 * El resto de combinaciones no son vectorizables */

/* axpby functions */
/* primeros elementos alineados para x[] e y[] */
__attribute__ ((noinline))
int
axpby_align_v1()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      y[i] = alpha*x[i] + beta*y[i];
    }
        dummy(x, y, y, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby_align_v1");
  check(y);
  return 0;
}

/* primeros elementos no alineados para x[] e y[] */
int axpby_align_v2()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      y[i+1] = alpha*x[i+1] + beta*y[i+1];
    }
    dummy(x, y, y, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby_align_v2");
  check(y);
  return 0;
}


/* accesos a memoria alineados para x[] e y[], intrinseco */
int axpby_align_v1_intr()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vX, vY, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++) {
    valpha = _mm256_set1_ps(alpha);      //valpha = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_ps(beta);       // vbeta = _mm256_load1_ps(&beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN) {
      vX = _mm256_load_ps(&x[i]);
      vY = _mm256_load_ps(&y[i]);
      vX = _mm256_mul_ps(valpha, vX);
      vY = _mm256_mul_ps(vbeta, vY);
      vY = _mm256_add_ps(vX, vY);
      _mm256_store_ps(&y[i],vY);
    }
    dummy(x, y, y, alpha, beta);
  }
#else
  __m256d vX, vY, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++) {
    valpha = _mm256_set1_pd(alpha);      //valpha = _mm256_load1_pd(&alpha);
    vbeta = _mm256_set1_pd(beta);      // vbeta = _mm256_load1_pd(&beta);
    for (int i = 0; i < LEN; i+= AVX_LEN) {
      vX = _mm256_load_pd(&x[i]);
      vY = _mm256_load_pd(&y[i]);
      vX = _mm256_mul_pd(valpha, vX);
      vY = _mm256_mul_pd(vbeta, vY);
      vY = _mm256_add_pd(vX, vY);
      _mm256_store_pd(&y[i],vY);
    }
    dummy(x, y, y, alpha, beta);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "axpby_align_v1_intr");
  check(y);
  return 0;
}

/* accesos a memoria no alineados para x[] e y[], intrinseco */
int axpby_align_v2_intr()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vX, vY, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++) {
    valpha = _mm256_set1_ps(alpha);      //valpha = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_ps(beta);       // vbeta = _mm256_load1_ps(&beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN) {
      vX = _mm256_loadu_ps(&x[i+1]);
      vY = _mm256_loadu_ps(&y[i+1]);
      vX = _mm256_mul_ps(valpha, vX);
      vY = _mm256_mul_ps(vbeta, vY);
      vY = _mm256_add_ps(vX, vY);
      _mm256_storeu_ps(&y[i+1],vY);
    }
    dummy(x, y, y, alpha, beta);
  }
#else
  __m256d vX, vY, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++) {
    valpha = _mm256_set1_pd(alpha);      //valpha = _mm256_load1_pd(&alpha);
    vbeta = _mm256_set1_pd(beta);       // vbeta = _mm256_load1_pd(&beta);
    for (int i = 0; i < LEN; i+= AVX_LEN) {
      vX = _mm256_loadu_pd(&x[i+1]);
      vY = _mm256_loadu_pd(&y[i+1]);
      vX = _mm256_mul_pd(valpha, vX);
      vY = _mm256_mul_pd(vbeta, vY);
      vY = _mm256_add_pd(vX, vY);
      _mm256_storeu_pd(&y[i+1],vY);
    }
    dummy(x, y, y, alpha, beta);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "axpby_align_v2_intr");
  check(y);
  return 0;
}

/* datos no alineados, intrinseco alineado */
int axpby_align_v1_intru()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vX, vY, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++) {
    valpha = _mm256_set1_ps(alpha);      //valpha = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_ps(beta);      // vbeta = _mm256_load1_ps(&beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN) {
      vX = _mm256_load_ps(&x[i+1]);
      vY = _mm256_load_ps(&y[i+1]);
      vX = _mm256_mul_ps(valpha, vX);
      vY = _mm256_mul_ps(vbeta, vX);
      vY = _mm256_add_ps(vX, vY);
      _mm256_store_ps(&y[i+1],vY);
    }
    dummy(x, y, y ,alpha, beta);
  }
#else
  __m256d vX, vY, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++) {
    valpha = _mm256_set1_pd(alpha);      //valpha = _mm256_load1_pd(&alpha);
    vbeta = _mm256_set1_pd(beta);      //vbeta = _mm256_load1_pd(&beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN) {
      vX = _mm256_load_pd(&x[i+1]);
      vY = _mm256_load_pd(&y[i+1]);
      vX = _mm256_mul_pd(valpha, vX);
      vY = _mm256_mul_pd(vbeta, vX);
      vY = _mm256_add_pd(vX, vY);
      _mm256_store_pd(&y[i+1], vY);
    }
    dummy(x, y, y, alpha, beta);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "axpby_align_v1_intru");
  check(y);
  return 0;
}

/* primeros elementos no alineados de x[] */
int axpby_align_v3()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        y[i] = alpha*x[i+1] + beta*y[i];
    }
    dummy(x, y, y, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpy_align_v3");
  check(y);
  return 0;
}

/* primeros elementos no alineados de y[] */
int axpby_align_v4()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        y[i+1] = alpha*x[i] + beta*y[i+1];
    }
    dummy(x, y, y, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpy_align_v4");
  check(y);
  return 0;
}

/* primeros elementos no alineados del load y[] */
int axpby_align_v5()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        y[i] = alpha*x[i] + beta*y[i+1];
    }
    dummy(x, y, y, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpy_align_v5");
  check(y);
  return 0;
}

/* primeros elementos no alineados de los loads */
int axpby_align_v6()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        y[i] = alpha*x[i+1] + beta*y[i+1];
    }
    dummy(x, y, y, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpy_align_v6");
  check(y);
  return 0;
}


int main(int argc, char *argv[])
{
  int mask = 0b110000;
  
  if (argc == 2) {
    // conversión de parámetro de binario a entero (base 2)
    mask = strtol(argv[1], NULL, 2);
  }

  // printf("NTIMES: %u\n", NTIMES);
  // printf("Direcciones de los vectores\n");
  // printf("  @x[0]: %p\n", &x);
  // printf("  @x[8]: %p\n", &x[8]);
  // printf("\n");

  printf("                       Time      TPE\n");
  printf("          Loop          ns      ps/el      Checksum\n");

  if (mask & 0b100000)
  {
	  axpby_align_v1();         /* todo alineado */
	  axpby_align_v1_intr();    /* v1 con intrinsecos */
	  // axpy_align_v1_intru();   /* v1 con intrinsecos pero vectores no alineados */
  }
  if (mask & 0b010000)
  {
	  axpby_align_v2();         /* todo no alineado */
	  axpby_align_v2_intr();    /* v2 con intrínsecos */
  }
  if (mask & 0b001000) axpby_align_v3();  /* x[] no alineado */
  if (mask & 0b000100) axpby_align_v4();  /* y[] no alineado */
  if (mask & 0b000010) axpby_align_v5();  /* load y[] no alineado */
  if (mask & 0b000001) axpby_align_v6();  /* loads no alineados */

  exit(0);
}

