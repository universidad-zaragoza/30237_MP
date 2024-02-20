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
#define FLOP_IT    (unsigned long int)  2     /* 2 FLOP per iteration */

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
static real alpha = 0.9;
static real beta = 0.5;

int dummy(real a[], real alpha, real beta);

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
  for (unsigned int i = 0; i < LEN; i++)
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
    for (unsigned int j = 0; j < LEN; j++)
    {
	    x[j] = 1.0;
    }
    return 0;
}

__attribute__ ((noinline))
void results(const double wall_time, const char *loop)
{
    printf("%18s  %6.1f    %6.1f     ",
            loop /* loop name */,
            wall_time/(1e-9*NTIMES),     /* ns/loop */
            wall_time/(1e-12*NTIMES*LEN) /* ps/el */);
}

/* scale and shift functions */
/* primer elemento alineado */
__attribute__ ((noinline))
int
ss_align_v1()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        x[i] = alpha*x[i] + beta;
    }
    dummy(x, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "ss_align_v1");
  check(x);
  return 0;
}

/* primeros elementos no alineados */
int ss_align_v2()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        x[i+1] = alpha*x[i+1] + beta;
    }
    dummy(x, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "ss_align_v2");
  check(x);
  return 0;
}


/* accesos a memoria alineados, intrinseco */
int ss_align_v1_intr()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vX, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    valpha = _mm256_set1_ps(alpha);      //vscalar = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_ps(beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vX = _mm256_load_ps(&x[i]);
      vX = _mm256_mul_ps(valpha, vX);
      vX = _mm256_add_ps(vX, vbeta);
      _mm256_store_ps(&x[i], vX);
    }
    dummy(x, alpha, beta);
  }
#else
  __m256d vX, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    valpha = _mm256_set1_pd(alpha);
    vbeta = _mm256_set1_pd(beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vX = _mm256_load_pd(&x[i]);
      vX = _mm256_mul_pd(valpha, vX);
      vX = _mm256_add_pd(vX, vbeta);
      _mm256_store_pd(&x[i], vX);
    }
    dummy(x, alpha, beta);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "ss_align_v1_intr");
  check(x);
  return 0;
}

/* accesos a memoria no alineados, intrinseco */
int ss_align_v2_intr()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vX, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    valpha = _mm256_set1_ps(alpha);      //vscalar = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_ps(beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vX = _mm256_loadu_ps(&x[i+1]);
      vX = _mm256_mul_ps(valpha, vX);
      vX = _mm256_add_ps(vbeta, vX);
      _mm256_storeu_ps(&x[i+1], vX);
    }
    dummy(x, alpha, beta);
  }
#else
  __m256d vX, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    valpha = _mm256_set1_pd(alpha);      //vscalar = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_pd(beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vX = _mm256_loadu_pd(&x[i+1]);
      vX = _mm256_mul_pd(valpha, vX);
      vX = _mm256_add_pd(vbeta, vX);
      _mm256_storeu_pd(&x[i+1], vX);
    }
    dummy(x, alpha, beta);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "ss_align_v2_intr");
  check(x);
  return 0;
}

/* datos no alineados, intrinseco alineado */
int ss_align_v1_intru()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vX, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    valpha = _mm256_set1_ps(alpha);      //vscalar = _mm256_load1_ps(&scalar);
    vbeta = _mm256_set1_ps(beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vX = _mm256_load_ps(&x[i+1]);
      vX = _mm256_mul_ps(valpha, vX);
      vX = _mm256_add_ps(vbeta, vX);
      _mm256_store_ps(&x[i+1], vX);
    }
    dummy(x, alpha, beta);
  }
#else
  __m256d vX, valpha, vbeta;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    valpha = _mm256_set1_ps(alpha);      //vscalar = _mm256_load1_ps(&alpha);
    vbeta = _mm256_set1_ps(beta);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vX = _mm256_load_pd(&x[i+1]);
      vX = _mm256_mul_pd(valpha, vX);
      vX = _mm256_add_pd(vbeta, vX);
      _mm256_store_pd(&x[i+1], vX);
    }
    dummy(x, alpha, beta);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "ss_align_v1_intru");
  check(x);
  return 0;
}

int main()
{
  // printf("NTIMES: %u\n", NTIMES);

  printf("Direcciones de los vectores\n");
  printf("  @x[0]: %p\n", &x);
  printf("  @x[8]: %p\n", &x[8]);
  printf("\n");

  printf("                      Time      TPE\n");
  printf("         Loop          ns      ps/el      Checksum\n");

  ss_align_v1();         /* x[] alineado */
  ss_align_v2();         /* x[] no alineado */
  ss_align_v1_intr();    /* v1 con intrinsecos */
  ss_align_v2_intr();    /* v2 con intrínsecos */
  //ss_align_v1_intru();     /* v1 con intrinsecos pero vectores no alineados */

  exit(0);
}

