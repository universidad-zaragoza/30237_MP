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
static real a[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real b[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real c[LEN+1] __attribute__((aligned(SIMD_ALIGN)));

static real scalar = 3.0;

int dummy(real a[], real b[], real c[], real scalar);

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
__attribute__((optimize("no-tree-vectorize")))
void check(const real arr[LEN])
{
  real sum = 0;
  for (unsigned int i = 0; i < LEN; i++)
    sum += arr[i];

  printf("%f \n", sum);
}

__attribute__((optimize("no-tree-vectorize")))
__attribute__ ((noinline))
int init()
{
    for (unsigned int j = 0; j < LEN; j++)
    {
	    a[j] = 1.0;
	    b[j] = 2.0;
	    c[j] = 0.0;
    }
    b[69] = 69.0;
    c[69] = 69.0;

    for (unsigned int j = 0; j < LEN; j++)
		a[j] = 2.0E0 * a[j];

  return 0;
}

__attribute__ ((noinline))
void results(const double wall_time, const char *loop)
{
    printf("%20s  %6.1f    %6.1f     ",
            loop /* loop name */,
            wall_time/(1e-9*NTIMES),     /* ns/loop */
            wall_time/(1e-12*NTIMES*LEN) /* ps/el */);
}

/* triad functions */
/* primeros elementos alineados */
__attribute__ ((noinline))
int
triad_align_v1()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        a[i] = b[i] + scalar*c[i];
    }
    dummy(a, b, c, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_align_v1");
  check(a);
  return 0;
}

/* primeros elementos no alineados */
int triad_align_v2()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        a[i+1] = b[i+1] + scalar*c[i+1];
    }
    dummy(a, b, c, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_align_v2");
  check(a);
  return 0;
}


/* accesos a memoria alineados, intrinseco */
int triad_align_v1_intr()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vA, vB, vC, vscalar;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    vscalar = _mm256_set1_ps(scalar);      //vscalar = _mm256_load1_ps(&scalar);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vB = _mm256_load_ps(&b[i]);
      vC = _mm256_load_ps(&c[i]);
      vC = _mm256_mul_ps(vscalar, vC);
      vA = _mm256_add_ps(vB, vC);
      _mm256_store_ps(&a[i], vA);
    }
    dummy(a, b, c, scalar);
  }
#else
  __m256d vA, vB, vC, vscalar;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    vscalar = _mm256_set1_pd(scalar);      //vscalar = _mm256_load1_ps(&scalar);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vB = _mm256_load_pd(&b[i]);
      vC = _mm256_load_pd(&c[i]);
      vC = _mm256_mul_pd(vscalar, vC);
      vA = _mm256_add_pd(vB, vC);
      _mm256_store_pd(&a[i], vA);
    }
    dummy(a, b, c, scalar);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "triad_align_v1_intr");
  check(a);
  return 0;
}

/* accesos a memoria no alineados, intrinseco */
int triad_align_v2_intr()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vA, vB, vC, vscalar;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    vscalar = _mm256_set1_ps(scalar);      //vscalar = _mm256_load1_ps(&scalar);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vB = _mm256_loadu_ps(&b[i+1]);
      vC = _mm256_loadu_ps(&c[i+1]);
      vC = _mm256_mul_ps(vscalar, vC);
      vA = _mm256_add_ps(vB, vC);
      _mm256_storeu_ps(&a[i+1], vA);
    }
    dummy(a, b, c, scalar);
  }
#else
  __m256d vA, vB, vC, vscalar;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    vscalar = _mm256_set1_pd(scalar);      //vscalar = _mm256_load1_ps(&scalar);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vB = _mm256_loadu_pd(&b[i+1]);
      vC = _mm256_loadu_pd(&c[i+1]);
      vC = _mm256_mul_pd(vscalar, vC);
      vA = _mm256_add_pd(vB, vC);
      _mm256_storeu_pd(&a[i+1], vA);
    }
    dummy(a, b, c, scalar);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "triad_align_v2_intr");
  check(a);
  return 0;
}

/* datos no alineados, intrinseco alineado */
int triad_align_v1_intru()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0
  __m256 vA, vB, vC, vscalar;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    vscalar = _mm256_set1_ps(scalar);      //vscalar = _mm256_load1_ps(&scalar);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vB = _mm256_load_ps(&b[i+1]);
      vC = _mm256_load_ps(&c[i+1]);
      vC = _mm256_mul_ps(vscalar, vC);
      vA = _mm256_add_ps(vB, vC);
      _mm256_store_ps(&a[i+1],vA);
    }
    dummy(a, b, c, scalar);
  }
#else
  __m256d vA, vB, vC, vscalar;
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    vscalar = _mm256_set1_pd(scalar);      //vscalar = _mm256_load1_ps(&scalar);
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
    {
      vB = _mm256_load_pd(&b[i+1]);
      vC = _mm256_load_pd(&c[i+1]);
      vC = _mm256_mul_pd(vscalar, vC);
      vA = _mm256_add_pd(vB, vC);
      _mm256_store_pd(&a[i+1], vA);
    }
    dummy(a, b, c, scalar);
  }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "triad_align_v1_intru");
  check(a);
  return 0;
}

int main()
{
  // printf("NTIMES: %u\n", NTIMES);

  printf("Direcciones de los vectores\n");
  printf("  @a[0]: %p\n", &a);
  printf("  @b[0]: %p\n", &b);
  printf("  @c[0]: %p\n", &c);
  printf("  @c[8]: %p\n", &c[8]);
  printf("\n");

  printf("                      Time      TPI\n");
  printf("         Loop          ns      ps/el      Checksum\n");

  triad_align_v1();         /* a[],b[],c[] alineados */
  triad_align_v2();         /* a[],b[],c[] no alineados */
  triad_align_v1_intr();    /* v1 con intrinsecos */
  triad_align_v2_intr();    /* v2 con intrínsecos */
  //triad_align_v1_intru();     /* v1 con intrinsecos pero vectores no alineados */

  exit(0);
}

