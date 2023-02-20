/*
 *  The output includes several columns:
 *      Loop:       name of the loop
 *      Time(ns):   time in nanoseconds to run the loop
 *	    ps/el: 	  	picoseconds per vector element
 *      Checksum:   checksum calculated when the test has run
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
    #define LEN     1024
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
                                                         
#define NTIMES      (unsigned long int) (FLOP_COUNT/(LEN*FLOP_IT))    /* iteraciones bucle externo */

#define SIMD_ALIGN  64  /* 512 bits (preparado para AVX-512) */

static real a[2*LEN] __attribute__((aligned(SIMD_ALIGN)));
static real b[2*LEN] __attribute__((aligned(SIMD_ALIGN)));
static real c[2*LEN] __attribute__((aligned(SIMD_ALIGN)));

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
#ifndef __INTEL_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
void check(real arr[LEN])
{
  real sum = 0;
#ifdef __INTEL_COMPILER
  #pragma novector
#endif
  for (unsigned int i = 0; i < LEN; i++)
    sum += arr[i];

  printf("%f \n", sum);
}

#ifndef __INTEL_COMPILER
  __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
int init()
{
#ifdef __INTEL_COMPILER
  #pragma novector
#endif
  for (unsigned int j = 0; j < LEN; j++)
  {
    a[j] = 1.0;
    b[j] = 2.0;
    c[j] = 0.0;
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

/* funciones de cálculo */
#ifndef __INTEL_COMPILER
  __attribute__((optimize("no-tree-vectorize")))
#endif
int triad_stride_esc()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
 {
#ifdef __INTEL_COMPILER
  #pragma novector
#endif
    for (unsigned int i = 0; i < 2*LEN; i+=2)
    {
      a[i] = b[i] + scalar*c[i];
    }
    dummy(a, b, c, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_stride_esc");
  check(a);
  return 0;
}

int triad_stride_vec()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < 2*LEN; i+=2)
    {
      a[i] = b[i] + scalar*c[i];
    }
    dummy(a, b, c, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_stride_vec");
  check(a);
  return 0;
}

#if 0
int triad_stride_v2(real * restrict va, real * restrict vb, real * restrict vc)
{
  real *aa = __builtin_assume_aligned(va, SIMD_ALIGN);
  real *bb = __builtin_assume_aligned(vb, SIMD_ALIGN);
  real *cc = __builtin_assume_aligned(vc, SIMD_ALIGN);
  double start_t, end_t;

  init();
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < 2*LEN; i+=2)
    {
      aa[i] = bb[i] + scalar*cc[i];
    }
    dummy(aa, bb, cc, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_stride_v2");
  check(aa);
  return 0;
}
#endif

int main()
{
  printf("                     Time       TPI\n");
  printf("             Loop     ns       ps/el     Checksum\n");
  triad_stride_esc();
  triad_stride_vec();
  //triad_stride_v2(a,b,c);
  return 0;
}

