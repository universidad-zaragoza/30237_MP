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

/* LEN+2 para evitar problemas con las inicializaciones */
/* LEN+1 porque hay recorridos que se inician en el elemento 1 */
static real a[LEN+2] __attribute__((aligned(SIMD_ALIGN)));
static real b[LEN+2] __attribute__((aligned(SIMD_ALIGN)));
static real c[LEN+2] __attribute__((aligned(SIMD_ALIGN)));

static real scalar = 0.03;

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
int init(real *va, real *vb, real *vc)
{
    for (unsigned int j = 0; j < LEN+1; j++)
    {
        va[j] = 1.0;
        vb[j] = 2.0;
        vc[j] = 0.0;
    }
    vb[69] = 69.0;
    vc[69] = 69.0;

    for (unsigned int j = 0; j < LEN; j++)
        va[j] = 2.0E0 * va[j];

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

/* triad functions */
__attribute__ ((noinline))
int
triad_alias_v1(real *va, real *vb, real *vc)
{
  double start_t, end_t;

  init(va, vb, vc);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      va[i] = vb[i] + scalar*vc[i];
    }
    dummy(va, vb, vc, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_alias_v1");
  check(vc);
  return 0;
}

__attribute__ ((noinline))
int
triad_alias_v2(real * restrict va, real * restrict vb, real * restrict vc)
{
  double start_t, end_t;

  init(va, vb, vc);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      va[i] = vb[i] + scalar*vc[i];
    }
    dummy(va, vb, vc, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_alias_v2");
  check(va);
  return 0;
}

int
triad_alias_v3(real *va, real *vb, real *vc)
{
  double start_t, end_t;

  init(va, vb, vc);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    #pragma GCC ivdep
    for (unsigned int i = 0; i < LEN; i++)
    {
      va[i] = vb[i] + scalar*vc[i];
    }
    dummy(va, vb, vc, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_alias_v3");
  check(va);
  return 0;
}

int triad_alias_v4(real * restrict va, real * restrict vb, real * restrict vc)
{
  real *aa = __builtin_assume_aligned(va, SIMD_ALIGN);
  real *bb = __builtin_assume_aligned(vb, SIMD_ALIGN);
  real *cc = __builtin_assume_aligned(vc, SIMD_ALIGN);
  double start_t, end_t;

  init(aa, bb, cc);
  start_t = get_wall_time();

  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < LEN; i++)
    {
      aa[i] = bb[i] + scalar*cc[i];
    }
    dummy(aa, bb, cc, scalar);
  }
  end_t = get_wall_time();
  results(end_t - start_t, "triad_alias_v4");
  check(va);
  return 0;
}

/* variables globales */
int triad()
{
  double start_t, end_t;

  init(a, b, c);
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
  results(end_t - start_t, "triad");
  check(a);
  return 0;
}

int main()
{
  //posix_memalign((void **) &x, SIMD_ALIGN, (LEN+1)*sizeof(real));
  //posix_memalign((void **) &y, SIMD_ALIGN, (LEN+1)*sizeof(real));
  //posix_memalign((void **) &z, SIMD_ALIGN, (LEN+1)*sizeof(real));
  //x = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
  //y = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
  //z = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
    
  /* a[] = b[] + scalar*c[] */


  printf("                     Time       TPI\n");
  printf("             Loop     ns       ps/el     Checksum\n");

  triad_alias_v1(&c[1], b, c);      /* solapamiento y dependencia */
  triad_alias_v1(c, &b[1], &c[1]);  /* solapamiento, no dependencia */
  triad_alias_v1(c, b, c);          /* solapamiento, no dependencia */
  triad_alias_v1(a, b, c);          /* no solapamiento, no dependencia */

  /* restrict en parametros */
  triad_alias_v2(&a[1], &b[1], &c[1]);  /* no solapamiento, no dependencia */
  triad_alias_v2(a, b, c);              /* no solapamiento, no dependencia */

  /* #pragma GCC ivdep */
  triad_alias_v3(&a[1], &b[1], &c[1]);  /* no solapamiento, no dependencia */
  triad_alias_v3(a, b, c);              /* no solapamiento, no dependencia */

  /* restrict en parametros + __builtin_assume_aligned() */
  triad_alias_v4(a, b, c);             /* no solapamiento, no dependencia */

  /* triad p1 */
  triad();                             /* solapamiento, no dependencia */

  return 0;
}

