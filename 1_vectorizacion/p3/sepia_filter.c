/* Conversión de imagen RGB a tonos sepia
 * (implementaciones varias para evaluar su rendimiento) */

/* Jesús Alastruey Benedé
 * v2.0, 2-marzo-2021
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
#include "jpeg_handler.h"
#include "include/jpeglib.h"
#include "sepia_filter.h"
#include "misc.h"


int dummy(image_t *im1, image_t *im2);
//----------------------------------------------------------------------------

/* factores y desplazamientos para conversión a sepia */
static const float
sepia[3][3] = {
   { 0.393, 0.769, 0.189 },
   { 0.349, 0.686, 0.168 },
   { 0.272, 0.534, 0.131 }
};
//----------------------------------------------------------------------------

#define MAXPIXV  255.0f
//----------------------------------------------------------------------------

void
sepia_filter_roundf0(image_t * image_in, image_t * image_out)
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            image_out->pixels[3*i + 0] = roundf(
                fminf(MAXPIXV,
                          sepia[0][0]*image_in->pixels[3*i + 0] + 
                          sepia[0][1]*image_in->pixels[3*i + 1] + 
                          sepia[0][2]*image_in->pixels[3*i + 2]));
            /* G */
            image_out->pixels[3*i + 1] = roundf(
                fminf(MAXPIXV,
                          sepia[1][0]*image_in->pixels[3*i + 0] + 
                          sepia[1][1]*image_in->pixels[3*i + 1] + 
                          sepia[1][2]*image_in->pixels[3*i + 2]));
            /* B */
            image_out->pixels[3*i + 2] = roundf(
                fminf(MAXPIXV,
                          sepia[2][0]*image_in->pixels[3*i + 0] + 
                          sepia[2][1]*image_in->pixels[3*i + 1] + 
                          sepia[2][2]*image_in->pixels[3*i + 2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_roundf0");
}
//----------------------------------------------------------------------------

/* cambios respecto sepia_filter_roundf_0(): restricts, #pragma GCC ivdep */
void
sepia_filter_roundf1(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            pixels_out[3*i + 0] = roundf(fminf(MAXPIXV,
                          sepia[0][0]*pixels_in[3*i + 0] + 
                          sepia[0][1]*pixels_in[3*i + 1] + 
                          sepia[0][2]*pixels_in[3*i + 2]));
            /* G */
            pixels_out[3*i + 1] = roundf(fminf(MAXPIXV,
                          sepia[1][0]*pixels_in[3*i + 0] + 
                          sepia[1][1]*pixels_in[3*i + 1] + 
                          sepia[1][2]*pixels_in[3*i + 2]));
            /* B */
            pixels_out[3*i + 2] = roundf(fminf(MAXPIXV,
                          sepia[2][0]*pixels_in[3*i + 0] + 
                          sepia[2][1]*pixels_in[3*i + 1] + 
                          sepia[2][2]*pixels_in[3*i + 2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_roundf1");
}
//----------------------------------------------------------------------------

/* cambios respecto sepia_filter_roundf2(): cast en lugar de roundf() */
/* https://www.cs.tut.fi/~jkorpela/round.html */
void
sepia_filter_cast0(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
                          0.5 + 
                          sepia[0][0]*pixels_in[3*i + 0] + 
                          sepia[0][1]*pixels_in[3*i + 1] + 
                          sepia[0][2]*pixels_in[3*i + 2]));
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
                          0.5 +
                          sepia[1][0]*pixels_in[3*i + 0] + 
                          sepia[1][1]*pixels_in[3*i + 1] + 
                          sepia[1][2]*pixels_in[3*i + 2]));
            /* B */
            pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
                          0.5 +
                          sepia[2][0]*pixels_in[3*i + 0] + 
                          sepia[2][1]*pixels_in[3*i + 1] + 
                          sepia[2][2]*pixels_in[3*i + 2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_cast0");
}
//----------------------------------------------------------------------------

/* cambios respecto sepia_filter_cast0(): cast de la constante 0.5 a float */
void
sepia_filter_cast1(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* el cast float mejora las prestaciones!! */
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
                          0.5f +
                          sepia[0][0]*pixels_in[3*i + 0] + 
                          sepia[0][1]*pixels_in[3*i + 1] + 
                          sepia[0][2]*pixels_in[3*i + 2]));
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
                          0.5f +
                          sepia[1][0]*pixels_in[3*i + 0] + 
                          sepia[1][1]*pixels_in[3*i + 1] + 
                          sepia[1][2]*pixels_in[3*i + 2]));
            /* B */
            pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
                          0.5f +
                          sepia[2][0]*pixels_in[3*i + 0] + 
                          sepia[2][1]*pixels_in[3*i + 1] + 
                          sepia[2][2]*pixels_in[3*i + 2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_cast1");
}
//----------------------------------------------------------------------------

/* cambios respecto sepia_filter_cast1(): no suma 0.5f a los valores RGB calculados */
void
sepia_filter_cast2(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
                          sepia[0][0]*pixels_in[3*i + 0] + 
                          sepia[0][1]*pixels_in[3*i + 1] + 
                          sepia[0][2]*pixels_in[3*i + 2]));
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
                          sepia[1][0]*pixels_in[3*i + 0] + 
                          sepia[1][1]*pixels_in[3*i + 1] + 
                          sepia[1][2]*pixels_in[3*i + 2]));
            /* B */
            pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
                          sepia[2][0]*pixels_in[3*i + 0] + 
                          sepia[2][1]*pixels_in[3*i + 1] + 
                          sepia[2][2]*pixels_in[3*i + 2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_cast2");
}
//----------------------------------------------------------------------------

/* cambios respecto sepia_filter_cast1(): atributo para no vectorizar */
__attribute__((optimize("no-tree-vectorize")))
void
sepia_filter_cast_esc(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i++)
        {
            /* el cast float mejora las prestaciones!! */
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
                          0.5f +
                          sepia[0][0]*pixels_in[3*i + 0] + 
                          sepia[0][1]*pixels_in[3*i + 1] + 
                          sepia[0][2]*pixels_in[3*i + 2]));
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
                          0.5f +
                          sepia[1][0]*pixels_in[3*i + 0] + 
                          sepia[1][1]*pixels_in[3*i + 1] + 
                          sepia[1][2]*pixels_in[3*i + 2]));
            /* B */
            pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
                          0.5f +
                          sepia[2][0]*pixels_in[3*i + 0] + 
                          sepia[2][1]*pixels_in[3*i + 1] + 
                          sepia[2][2]*pixels_in[3*i + 2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_cast_esc");
}
//----------------------------------------------------------------------------

/* transformación de datos de entrada y salida de formato vector de estructuras (Array of Structs, AoS)
 * (R0 G0 B0 R1 G1 B1 ... Rn-1 Gn-1 Bn-1)
 * a estructura de vectores (Struct of Arrays, SoA)
 * (R0 R1 ... Rn-1 G0 G1 ... Gn-1 B0 B1 ... Bn-1) */
void
sepia_filter_SOA0(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char *R_in, *G_in, *B_in, *R_out, *G_out, *B_out;
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    /* transform data layout */
    R_in = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    G_in = R_in + 1*width*height;
    B_in = R_in + 2*width*height;

    R_out = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    G_out = R_out + 1*width*height;
    B_out = R_out + 2*width*height;

    /* transformación AoS -> SoA */
    /* COMPLETAR ... */
    #pragma GCC ivdep
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
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            // R_out[i] = f(R_in[i], G_in[i], B_in[i]);
            // G_out[i] = ...
            // B_out[i] = ...
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_SOA0");

    /* transformación SoA -> AoS */
    /* COMPLETAR ... */
    #pragma GCC ivdep
    for (int i=0; i < height*width; i++)
    {
        // = R_out[i];
        // = G_out[i];
        // = B_out[i];
    }

    free(R_in); free(R_out);
}
//----------------------------------------------------------------------------

/* como SOA0 pero contando el tiempo de la transformacion de datos */
void
sepia_filter_SOA1(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char *R_in, *G_in, *B_in, *R_out, *G_out, *B_out;
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    /* transform data layout */
    R_in = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    G_in = R_in + 1*width*height;
    B_in = R_in + 2*width*height;

    R_out = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    G_out = R_out + 1*width*height;
    B_out = R_out + 2*width*height;

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        /* transformación AoS -> SoA */
        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /*
            R_in[i] = ...;
            G_in[i] = ...; 
            B_in[i] = ...; */
        }

        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            // R_out[i] = f(R_in[i], G_in[i], B_in[i]);
            // G_out[i] = ...
            // B_out[i] = ...
        }

        /* transformación SoA -> AoS */
        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            // = R_out[i];
            // = G_out[i];
            // = B_out[i];
        }

        dummy(image_in, image_out);
    }

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_SOA1");

    free(R_in); free(R_out);
}


/* Cuidado, el tamaño de la imagen debería ser múltiplo de BLOCK */
#define BLOCK 64

 /* función que entrelaza la transformación de los datos con los cálculos a realizar.
    De esta forma, en lugar de necesitar nuevas variables
    con **todos** los valores RGB de la imagen en formato SOA,
    solamente son necesarias variables que almacenen **parte** de los valores RGB */
void
sepia_filter_block(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char __attribute__((aligned(SIMD_ALIGN))) R_in[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) G_in[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) B_in[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) R_out[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) G_out[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) B_out[BLOCK];
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
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_RGB;

    start_t = get_wall_time();
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i+= BLOCK)
        {
            /* transformación AoS -> SoA */
            /* pixels_in = ...;
            pixels_out = ...; */

            #pragma GCC ivdep
            for (int j = 0; j < BLOCK; j++)
            {
                // R_in[j] = ...;
                // G_in[j] = ...;
                // B_in[j] = ...;
            }
            /* conversión RGB -> sepia */
            #pragma GCC ivdep
            for (int j = 0; j < BLOCK; j++)
            {
                // R_out[j] = ...;
                // G_out[j] = ...;
                // B_out[j] = ...;
            }
            /* transformación SoA -> AoS */
            #pragma GCC ivdep
            for (int j = 0; j < BLOCK; j++)
            {
                // ... = R_out[j];
                // ... = G_out[j];
                // ... = B_out[j];
            }
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "sepiaf_block");
}
//----------------------------------------------------------------------------
