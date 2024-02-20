/*
 *  The output includes several columns:
 *  Loop:       name of the loop
 *  Time(ns):   time in nanoseconds to run the loop
 *  ps/el:      picoseconds per vector element
 *  Checksum:   checksum calculated when the test has run
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

#define NTIMES      (unsigned long int) (512*(4*5*1024*1024/LEN))    /* iteraciones bucle externo */
// NTIMES*LEN = 10*1024*1024*1024, no depende de LEN

#define SIMD_ALIGN  64  /* 512 bits (preparado para AVX-512) */

static real x[LEN] __attribute__((aligned(SIMD_ALIGN)));
static real y[LEN] __attribute__((aligned(SIMD_ALIGN)));
static real z[LEN] __attribute__((aligned(SIMD_ALIGN)));
static real scalar = 0.4;

static real umbral = 1.0/(LEN/2 - 1);

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
#ifndef __INTEL_LLVM_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
int 
set1d(real arr[LEN], real value, int stride)
{  
  if (stride == -1) {
    for (unsigned int i = 0; i < LEN; i++)
      arr[i] = 1. / (real) (i+1);
  }
  else if (stride == -2) {
    /* if (i > 65535) -> overflow of (i+1)*(i+1) */
    for (unsigned int i = 0; i < LEN; i++)
      arr[i] = 1. / (real) ((i+1) * (i+1));
  }
  else {
    for (unsigned int i = 0; i < LEN; i += stride)
      arr[i] = value;
  }
  return 0;
}

/* inhibimos vectorización en esta función
 * para que los informes de compilación sean más cómodos de leer */
#ifndef __INTEL_LLVM_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
void check(real arr[LEN])
{
  real sum = 0;
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
  real any = 0., one = 1.;
  int unit = 1, frac1 = -1;

  set1d(x, one, unit);
  set1d(y, any, frac1);
  set1d(z, any, frac1);

  return 0;
}

__attribute__ ((noinline))
void results(double wall_time, char *loop)
{
    printf("%18s  %6.1f    %6.1f     ",
          loop /* loop name */,
          wall_time/(1e-9*NTIMES),     /* ns/loop */
          wall_time/(1e-12*NTIMES*LEN) /* ps/element */);
}

#ifndef __INTEL_LLVM_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
int cond_esc()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
#ifdef __INTEL_LLVM_COMPILER
  #pragma novector
#endif
    for (unsigned int i = 0; i < LEN; i++)
    {
      if (y[i] < umbral)
         z[i] = y[i];
      else
         z[i] = x[i];
    }
    dummy(x, y, z, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "cond_esc");
  check(z);
  return 0;
}

int cond_vec()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      if (y[i] < umbral)
         z[i] = y[i];
      else
         z[i] = x[i];
    }
    dummy(x, y, z, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "cond_vec");
  check(z);
  return 0;
}

int main()
{
  printf("                     Time       TPE\n");
  printf("             Loop     ns       ps/el     Checksum\n");
  cond_esc();
  cond_vec();
  return 0;
}
