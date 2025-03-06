/* Conversión de imagen RGB a escala de grises *
 * (implementaciones varias para evaluar su rendimiento) */

/* http://en.wikipedia.org/wiki/Luma_(video)#Rec._601_luma_versus_Rec._709_luma_coefficients
 *     Y' = 0.299 R' + 0.587 G' + 0.114 B'
 */

/* Jesús Alastruey Benedé
 * v2.1, 1-marzo-2022
 */

#define _POSIX_C_SOURCE 200112L     /* para evitar el aviso al compilar
                                       con la función posix_memalign() */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <sys/times.h>
#include <malloc.h>
#include <math.h>
#include <jpeglib.h>

#include "jpeg_handler.h"
#include "rgb2gray.h"
#include "misc.h"


int dummy(image_t *im1, image_t *im2);
//----------------------------------------------------------------------------

void
rgb2gray_roundf0(image_t * image_in, image_t * image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i++)
        {
            image_out->pixels[i] = roundf(
                0.299*image_in->pixels[3*i + 0] + 
                0.587*image_in->pixels[3*i + 1] + 
                0.114*image_in->pixels[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_roundf0");
}
//----------------------------------------------------------------------------

/* cambios respecto rgb2gray_roundf_0(): restricts, #pragma GCC ivdep */
void
rgb2gray_roundf1(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
#if defined(__INTEL_LLVM_COMPILER)
        #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            pixels_out[i] = roundf(
                0.299*pixels_in[3*i + 0] + 
                0.587*pixels_in[3*i + 1] + 
                0.114*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_roundf1");
}
//----------------------------------------------------------------------------

/* cambios respecto rgb2gray_roundf2(): cast en lugar de roundf() */
/* https://www.cs.tut.fi/~jkorpela/round.html */
void
rgb2gray_cast0(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
#if defined(__INTEL_LLVM_COMPILER)
        #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            pixels_out[i] = (unsigned char) (0.5 + 
                0.299*pixels_in[3*i + 0] + 
                0.587*pixels_in[3*i + 1] + 
                0.114*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_cast0");
}
//----------------------------------------------------------------------------

/* cambios respecto rgb2gray_cast0(): cast de las constantes a float */
void
rgb2gray_cast1(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
#if defined(__INTEL_LLVM_COMPILER)
        #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            /* el cast float mejora las prestaciones!! */
            pixels_out[i] = (unsigned char) (0.5f + 
                0.299f*pixels_in[3*i + 0] + 
                0.587f*pixels_in[3*i + 1] + 
                0.114f*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_cast1");
}
//----------------------------------------------------------------------------

/* cambios respecto rgb2gray_cast1(): no suma 0.5f a los valores de gris calculados */
void
rgb2gray_cast2(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
#if defined(__INTEL_LLVM_COMPILER)
    #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            pixels_out[i] = (unsigned char)
               (0.299f*pixels_in[3*i + 0] + 
                0.587f*pixels_in[3*i + 1] + 
                0.114f*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_cast2");
}
//----------------------------------------------------------------------------

/* cambios respecto rgb2gray_cast1(): atributo para no vectorizar */
#ifndef __INTEL_LLVM_COMPILER
__attribute__((optimize("no-tree-vectorize")))
#endif
void
rgb2gray_cast_esc(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();
#ifdef __INTEL_LLVM_COMPILER
  #pragma clang loop vectorize(disable)
#endif
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i++)
        {
            /* el cast float mejora las prestaciones!! */
            pixels_out[i] = (unsigned char) (0.5f + 
                0.299f*pixels_in[3*i + 0] + 
                0.587f*pixels_in[3*i + 1] + 
                0.114f*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_cast_esc");
}
//----------------------------------------------------------------------------

/* transformación de datos de entrada de formato vector de estructuras (Array of Structs, AoS)
 * (R0 G0 B0 R1 G1 B1 ... Rn-1 Gn-1 Bn-1)
 * a estructura de vectores (Struct of Arrays, SoA)
 * (R0 R1 ... Rn-1 G0 G1 ... Gn-1 B0 B1 ... Bn-1) */
void
rgb2gray_SOA0(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char *R_in, *G_in, *B_in;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    /* transform data layout */
    R_in = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    G_in = R_in + 1*width*height;
    B_in = R_in + 2*width*height;

    /* transformación AoS -> SoA */
    /* COMPLETAR ... */
#if defined(__INTEL_LLVM_COMPILER)
    #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
    for (int i = 0; i < height*width; i++)
    {
        /*
        R_in[i] = ...;
        G_in[i] = ...; 
        B_in[i] = ...; */
    }

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        /* COMPLETAR ... */
#if defined(__INTEL_LLVM_COMPILER)
    #pragma clang loop vectorize(enable)
#else
        #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            // pixels_out[i] = f(R_in[i], G_in[i], B_in[i]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_SOA0");
    free(R_in);
}
//----------------------------------------------------------------------------

/* como SOA0 pero contando el tiempo de la transformacion de datos */
void
rgb2gray_SOA1(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char *R_in, *G_in, *B_in;
    unsigned char * restrict pixels_in  = image_in->pixels;
    unsigned char * restrict pixels_out = image_out->pixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    /* transform data layout */
    R_in = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    G_in = R_in + 1*width*height;
    B_in = R_in + 2*width*height;

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        /* transformación AoS -> SoA */
        /* COMPLETAR ... */
#if defined(__INTEL_LLVM_COMPILER)
         #pragma clang loop vectorize(enable)
#else
        #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            /*
            R_in[i] = ...;
            G_in[i] = ...; 
            B_in[i] = ...; */
        }

        /* COMPLETAR ... */
#if defined(__INTEL_LLVM_COMPILER)
    #pragma clang loop vectorize(enable)
#else
        #pragma GCC ivdep
#endif
        for (int i = 0; i < height*width; i++)
        {
            // pixels_out[i] = f(R_in[i], G_in[i], B_in[i]);
        }
        dummy(image_in, image_out);
    }

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_SOA1");
    free(R_in);
}


/* Cuidado, el tamaño de la imagen debería ser múltiplo de BLOCK */
#define BLOCK 64

 /* función que entrelaza la transformación de los datos con los cálculos a realizar.
    De esta forma, en lugar de necesitar nuevas variables
    con **todos** los valores RGB de la imagen en formato SOA,
    solamente son necesarias variables que almacenen **parte** de los valores RGB */
void
rgb2gray_block(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char __attribute__((aligned(SIMD_ALIGN))) R_in[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) G_in[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) B_in[BLOCK];
    unsigned char * restrict pixels_in;
    unsigned char * restrict pixels_out;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i+= BLOCK)
        {
            /* transformación AoS -> SoA */
            /* pixels_in = ...;
            pixels_out = ...; */

#if defined(__INTEL_LLVM_COMPILER)
            #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
            for (int j = 0; j < BLOCK; j++)
            {
                // R_in[j] = ...;
                // G_in[j] = ...;
                // B_in[j] = ...;
            }
            /* conversión RGB -> gris */
#if defined(__INTEL_LLVM_COMPILER)
            #pragma clang loop vectorize(enable)
#else
    #pragma GCC ivdep
#endif
            for (int j = 0; j < BLOCK; j++)
            {
                // pixels_out[i] = f(R_in[i], G_in[i], B_in[i]);
            }
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "rgb2gray_block");
}
//----------------------------------------------------------------------------
