/*
 *  The output includes several columns:
 *	Loop:		name of the loop
 *	Time(ns): 	time in nanoseconds to run the loop
 *	ps/it: 	    picoseconds per loop iteration
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

/* disable IACA_START, IACA_END */
#ifndef IACA
    #define IACA_START
    #define IACA_END
#else
    // lab102
    #include "/usr/local/include/iacaMarks.h"
    // central
    // #include "/usr/local/pkg/iaca-lin64/include/iacaMarks.h"
    // include local
    // #include "iaca-lin64/include/iacaMarks.h"
    // fermat
    // #include "/opt/intel/iaca-lin64/iacaMarks.h"
#endif

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

// para ejecuciones más rapidas con herramientos como Valgrind, por ejemplo */
// #define FLOP_COUNT  (unsigned long int) 3*4*5*1024*1024
                       
#define NTIMES      (unsigned long int) (FLOP_COUNT/(LEN*FLOP_IT))    /* iteraciones bucle externo */
                                  
#define SIMD_ALIGN  64  /* 512 bits (preparado para AVX-512) */
static real a[LEN] __attribute__((aligned(SIMD_ALIGN)));
static real b[LEN] __attribute__((aligned(SIMD_ALIGN)));
static real c[LEN] __attribute__((aligned(SIMD_ALIGN)));

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
void check(real arr[LEN])
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
	    a[j] = 1.0;
	    b[j] = 2.0;
	    c[j] = 0.0;
	}
    b[69] = 69.0;
    c[69] = 69.0;

    for (int j = 0; j < LEN; j++)
		a[j] = 2.0E0 * a[j];

  return 0;
}

__attribute__ ((noinline))
void results(double wall_time, char *loop)
{
    printf("%18s  %5.1f    %5.1f     ",
            loop /* loop name */,
            wall_time/(1e-9*NTIMES),     /* ns/loop */
            wall_time/(1e-12*NTIMES*LEN) /* ps/iteration */);
}

/* triad functions */
__attribute__ ((noinline))
int
triad()
{
    double start_t, end_t;

    init();
    start_t = get_wall_time();
    for (unsigned int nl = 0; nl < NTIMES; nl++)
    {
    // #pragma omp ...
        for (unsigned int i = 0; i < LEN; i++)
        {
            IACA_START
            a[i] = b[i] + scalar*c[i];
        }
        IACA_END
        dummy(a, b, c, scalar);
    }
    end_t = get_wall_time();
    results(end_t - start_t, "triad");
    check(a);
    return 0;
}

int main()
{
  // printf("LEN: %u\n\n", LEN);
  printf("triad kernel, LEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  printf("                     Time    TPI\n");
  printf("              Loop    ns     ps/it     Checksum \n");
  triad();
  exit(0);
}
