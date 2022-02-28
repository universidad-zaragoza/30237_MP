/*
 *  The output includes several columns:
 *  Loop:       name of the loop
 *  Time(ns):   time in nanoseconds to run the loop
 *  ps/it:      picoseconds per loop iteration (one element)
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
#define FLOP_IT    (unsigned long int)  3     /* 3 FLOP per iteration */

// Numero total de FLOP que queremos ejecutar
// Si es múltiplo de LEN y FLOP_IT se facilitan las cuentas */
#define FLOP_COUNT  (unsigned long int) 3*4*5*512*1024*1024
// este valor de FLOP_COUNT es múltiplo para las siguientes combinaciones de LEN y FLOP_IT
//   LEN={ 1k, 2k, 4k, ... 1M, 2M, ... 512M }
//   FLOP_IT={ 1, 2, 3, 4, 5, 6 }

// para ejecuciones más rapidas con SDE */
// #define FLOP_COUNT  (unsigned long int) 3*4*5*1024*1024
                                                         
#define NTIMES      (unsigned long int) (FLOP_COUNT/(LEN*FLOP_IT))    /* iteraciones bucle externo */

#define SIMD_ALIGN  64  /* 512 bits (preparado para AVX-512) */

/* LEN+1 porque hay recorridos que se inician en el elemento 1 */
static real x[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real y[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real z[LEN+1] __attribute__((aligned(SIMD_ALIGN)));
static real alpha = 0.4;
static real beta = 0.6;

int dummy(real x[], real y[], real z[], real alpha, real beta);

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
int init(real *vx, real *vy, real *vz)
{
    for (int j = 0; j < LEN+1; j++)
    {
        vx[j] = 2.0;
        vy[j] = 0.5;
        vz[j] = 0.0;
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

/* axpby functions */
__attribute__ ((noinline))
int
axpby_alias_v1(real *vz, real *vy, real *vx)
{
  double start_t, end_t;

  init(vx, vy, vz);
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        vz[i] = alpha*vx[i] + beta*vy[i];
    }
    dummy(vx, vy, vz, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby_alias_v1");
  check(vz);
  return 0;
}

__attribute__ ((noinline))
int
axpby_alias_v2(real * restrict vz, real * restrict vx, real * restrict vy)
{
  double start_t, end_t;

  init(vx, vy, vz);
  start_t = get_wall_time();
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
        vz[i] = alpha*vx[i] + beta*vy[i];
    }
    dummy(vx, vy, vz, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby_alias_v2");
  check(vz);
  return 0;
}

int
axpby_alias_v3(real *vz, real *vx, real *vy)
{
  double start_t, end_t;

  init(vx, vy, vz);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    #pragma GCC ivdep
    for (unsigned int i = 0; i < LEN; i++)
    {
      vz[i] = alpha*vx[i] + beta*vy[i];
    }
    dummy(vx, vy, vz, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby_alias_v3");
  check(vz);
  return 0;
}

int
axpby_alias_v4(real * restrict vz, real * restrict vx, real * restrict vy)
{
  real *xx = __builtin_assume_aligned(vx, SIMD_ALIGN);
  real *yy = __builtin_assume_aligned(vy, SIMD_ALIGN);
  real *zz = __builtin_assume_aligned(vz, SIMD_ALIGN);
  double start_t, end_t;

  init(xx, yy, zz);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      zz[i] = alpha*xx[i] + beta*yy[i];
    }
    dummy(xx, yy, zz, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby_alias_v4");
  check(zz);
  return 0;
}

/* variables globales */
int axpby()
{
  double start_t, end_t;

  init(x, y, z);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      y[i] = alpha*x[i] + beta*y[i];
    }
    dummy(x, y, z, alpha, beta);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "axpby");
  check(y);
  return 0;
}

int main()
{
  //posix_memalign((void **) &x, SIMD_ALIGN, (LEN+1)*sizeof(real));
  //posix_memalign((void **) &y, SIMD_ALIGN, (LEN+1)*sizeof(real));
  //x = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
  //y = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
    
  /* z[] = alpha*x[] + beta*y[] */

  printf("                     Time       TPI\n");
  printf("             Loop     ns       ps/el     Checksum\n");

  axpby_alias_v1(&y[1], x, y);      /* solapamiento y dependencia */
  axpby_alias_v1(y, &x[1], &y[1]);  /* solapamiento, no dependencia */
  axpby_alias_v1(y, x, y);          /* solapamiento, no dependencia */
  axpby_alias_v1(z, x, y);          /* no solapamiento, no dependencia */

  /* restrict en parametros */
  axpby_alias_v2(&z[1], &x[1], &y[1]);  /* no solapamiento, no dependencia */
  axpby_alias_v2(z, x, y);               /* no solapamiento, no dependencia */

  /* #pragma GCC ivdep */
  axpby_alias_v3(&z[1], &x[1], &y[1]);  /* no solapamiento, no dependencia */
  axpby_alias_v3(z, x, y);              /* no solapamiento, no dependencia */

  /* restrict en parametros + __builtin_assume_aligned() */
  axpby_alias_v4(z, x, y);             /* no solapamiento, no dependencia */

  /* axpby p1 */
  axpby();                             /* solapamiento, no dependencia */

  return 0;
}

