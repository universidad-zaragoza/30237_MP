/*
 *  The output includes several columns:
 *	Loop:		name of the loop
 *	Time(ns): 	time in nanoseconds to run the loop
 *	ps/it: 	    picoseconds per C loop iteration
 *	Checksum:	checksum calculated when the test has run
 */

#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <x86intrin.h>

#include "precision.h"

// Los vectores deben caber en la cache para que la velocidad de ejecución
// no esté limitada por el ancho de banda de memoria principal
#ifndef LEN 
    #define LEN     1024
#endif
#define FLOP_IT    (unsigned long int)  2     /* 2 FLOP per iteration */

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
static real x[LEN] __attribute__((aligned(SIMD_ALIGN)));
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
    for (int j = 0; j < LEN; j++)
    {
	    x[j] = 1.0;
	}
    return 0;
}

__attribute__ ((noinline))
void results(const double wall_time, const char *loop)
{
    printf("%18s  %5.1f    %5.1f     ",
            loop /* loop name */,
            wall_time/(1e-9*NTIMES),     /* ns/loop */
            wall_time/(1e-12*NTIMES*LEN) /* ps/el */);
}

/* scale and shift functions */
__attribute__ ((noinline))
int
scale_shift()
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
    results(end_t - start_t, "scale_shift");
    check(x);
    return 0;
}

__attribute__ ((noinline))
int
ss_intr_SSE()
{
    double start_t, end_t;

    init();
    start_t = get_wall_time();

#if PRECISION==0
    __m128 vX, valpha, vbeta;
    for (unsigned int nl = 0; nl < NTIMES; nl++)
    {
        valpha = _mm_set1_ps(alpha);     // valpha = _mm_load1_ps(&alpha);
        vbeta = _mm_set1_ps(beta);
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
        {
            vX = _mm_load_ps(&x[i]);
            vX = _mm_mul_ps(valpha, vX);
            vX = _mm_add_ps(vX, vbeta);
            _mm_store_ps(&x[i], vX);
        }
        dummy(x, alpha, beta);
    }
#else
    __m128d vX, valpha, vbeta;
    for (unsigned int nl = 0; nl < NTIMES; nl++)
    {
        valpha = _mm_set1_pd(alpha);     // valpha = _mm_load1_ps(&alpha);
        vbeta = _mm_set1_pd(beta);
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
        {
            vX = _mm_load_pd(&x[i]);
            vX = _mm_mul_pd(valpha, vX);
            vX = _mm_add_pd(vX, vbeta);
            _mm_store_pd(&x[i], vX);
        }
        dummy(x, alpha, beta);
    }
#endif

  end_t = get_wall_time();
  results(end_t - start_t, "ss_intr_SSE");
  check(x);
  return 0;
}


__attribute__ ((noinline))
int ss_intr_AVX()
{
  double start_t, end_t;

  init();
  start_t = get_wall_time();

#if PRECISION==0

#else

#endif

  end_t = get_wall_time();
  results(end_t - start_t, "ss_intr_AVX");
  check(x);
  return 0;
}

int main()
{
  // printf("LEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  printf("                     Time    TPI\n");
  printf("              Loop    ns     ps/el     Checksum \n");
  scale_shift();
  // ss_intr_SSE();
  // ss_intr_AVX();
  exit(0);
}
