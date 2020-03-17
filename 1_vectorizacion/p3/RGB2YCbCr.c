/* Conversión de imagen RGB a YCbCr
 * (implementaciones varias para evaluar su rendimiento) */

/* https://en.wikipedia.org/wiki/YCbCr#JPEG_conversion
 */

/* Jesús Alastruey Benedé
 * v2.0, 12-marzo-2020
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
#include "RGB2YCbCr.h"
#include "misc.h"


int dummy(image_t *im1, image_t *im2);
//----------------------------------------------------------------------------

/* factores y desplazamientos para conversión RGB -> YCbCr */
static const float
RGB2YCbCr[3][3] = {
   { 0.299,     0.587,     0.114    },
   {-0.168736, -0.331264,  0.500    },
   { 0.500,    -0.418688, -0.081312 }
};
static const float
RGB2YCbCr_offset[3] = { 0.0,  128.0,  128.0 };

//----------------------------------------------------------------------------

void
RGB2YCbCr_roundf0(image_t * image_in, image_t * image_out)
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
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i++)
        {
            /* Y */
            image_out->pixels[3*i + 0] = roundf(
                RGB2YCbCr_offset[0] +
                RGB2YCbCr[0][0]*image_in->pixels[3*i + 0] + 
                RGB2YCbCr[0][1]*image_in->pixels[3*i + 1] + 
                RGB2YCbCr[0][2]*image_in->pixels[3*i + 2]);
            /* Cb */
            image_out->pixels[3*i + 1] = roundf(
                RGB2YCbCr_offset[1] +
                RGB2YCbCr[1][0]*image_in->pixels[3*i + 0] + 
                RGB2YCbCr[1][1]*image_in->pixels[3*i + 1] + 
                RGB2YCbCr[1][2]*image_in->pixels[3*i + 2]);
            /* Cr */
            image_out->pixels[3*i + 2] = roundf(
                RGB2YCbCr_offset[2] +
                RGB2YCbCr[2][0]*image_in->pixels[3*i + 0] + 
                RGB2YCbCr[2][1]*image_in->pixels[3*i + 1] + 
                RGB2YCbCr[2][2]*image_in->pixels[3*i + 2]);

        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2YCbCr_roundf0");
}
//----------------------------------------------------------------------------

/* cambios respecto RGB2Gray_roundf_0(): restricts, #pragma GCC ivdep */
void
RGB2YCbCr_roundf1(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            pixels_out[3*i + 0] = roundf(
                RGB2YCbCr_offset[0] +
                RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
            /* G */
            pixels_out[3*i + 1] = roundf(
                RGB2YCbCr_offset[1] +
                RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
            /* B */
            pixels_out[3*i + 2] = roundf(
                RGB2YCbCr_offset[2] +
                RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2YCbCr_roundf1");
}
//----------------------------------------------------------------------------

/* cambios respecto RGB2YCbCr_roundf2(): cast en lugar de roundf() */
/* https://www.cs.tut.fi/~jkorpela/round.html */
void
RGB2YCbCr_cast0(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (0.5 + 
                RGB2YCbCr_offset[0] +
                RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (0.5 + 
                RGB2YCbCr_offset[1] +
                RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
            /* B */
            pixels_out[3*i + 2] =  (unsigned char) (0.5 + 
                RGB2YCbCr_offset[2] +
                RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2Gray_cast0");
}
//----------------------------------------------------------------------------

/* cambios respecto RGB2YCbCr_cast0(): cast de la constante 0.5 a float */
void
RGB2YCbCr_cast1(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* el cast float mejora las prestaciones!! */
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (0.5f + 
                RGB2YCbCr_offset[0] +
                RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (0.5f + 
                RGB2YCbCr_offset[1] +
                RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
            /* B */
            pixels_out[3*i + 2] =  (unsigned char) (0.5f + 
                RGB2YCbCr_offset[2] +
                RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2Gray_cast1");
}
//----------------------------------------------------------------------------

/* cambios respecto RGB2YCbCr_cast1(): no suma 0.5f a los valores Y,Cb,Cr calculados */
void
RGB2YCbCr_cast2(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (
                RGB2YCbCr_offset[0] +
                RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (
                RGB2YCbCr_offset[1] +
                RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
            /* B */
            pixels_out[3*i + 2] =  (unsigned char) (
                RGB2YCbCr_offset[2] +
                RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2Gray_cast2");
}
//----------------------------------------------------------------------------

/* cambios respecto RGB2YCbCr_cast1(): atributo para no vectorizar */
__attribute__((optimize("no-tree-vectorize")))
void
RGB2YCbCr_cast_esc(image_t * restrict image_in, image_t * restrict image_out)
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
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();

    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i++)
        {
            /* el cast float mejora las prestaciones!! */
            /* R */
            pixels_out[3*i + 0] = (unsigned char) (0.5f + 
                RGB2YCbCr_offset[0] +
                RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
            /* G */
            pixels_out[3*i + 1] = (unsigned char) (0.5f + 
                RGB2YCbCr_offset[1] +
                RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
            /* B */
            pixels_out[3*i + 2] =  (unsigned char) (0.5f + 
                RGB2YCbCr_offset[2] +
                RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
                RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
                RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2Gray_cast_esc");
}
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------

/* transformación de datos de entrada y salida de formato vector de estructuras (Array of Structs, AoS)
 * (R0 G0 B0 R1 G1 B1 ... Rn-1 Gn-1 Bn-1)
 * a estructura de vectores (Struct of Arrays, SoA)
 * (R0 R1 ... Rn-1 G0 G1 ... Gn-1 B0 B1 ... Bn-1) */
void
RGB2YCbCr_SOA0(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char *Rpixels, *Gpixels, *Bpixels, *Ypixels, *Cbpixels, *Crpixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_YCbCr;

    /* transform data layout */
    Rpixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    Gpixels = Rpixels + 1*width*height;
    Bpixels = Rpixels + 2*width*height;

    Ypixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    Cbpixels = Ypixels + 1*width*height;
    Crpixels = Ypixels + 2*width*height;

    /* transformación AoS -> SoA */
    /* COMPLETAR ... */
    #pragma GCC ivdep
    for (int i = 0; i < height*width; i++)
    {
        /*
        Rpixels[i] = ...;
        Gpixels[i] = ...; 
        Bpixels[i] = ...; */
    }

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            // Ypixels[i] = f(Rpixels[i], Gpixels[i], Bpixels[i]);
            // Cbpixels[i] = ...
            // Crpixels[i] = ...
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2YCbCrSOA0");

    /* transformación SoA -> AoS */
    /* COMPLETAR ... */
    #pragma GCC ivdep
    for (int i=0; i < height*width; i++)
    {
        // = Ypixels[i];
        // = Cbpixels[i];
        // = Crpixels[i];
    }

    free(Rpixels); free(Ypixels);
}
//----------------------------------------------------------------------------

/* como SOA0 pero contando el tiempo de la transformacion de datos */
void
RGB2YCbCr_SOA1(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char *Rpixels, *Gpixels, *Bpixels, *Ypixels, *Cbpixels, *Crpixels;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_YCbCr;

    /* transform data layout */
    Rpixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    Gpixels = Rpixels + 1*width*height;
    Bpixels = Rpixels + 2*width*height;

    Ypixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
    Cbpixels = Ypixels + 1*width*height;
    Crpixels = Ypixels + 2*width*height;

    start_t = get_wall_time();
    for (int it=0; it < NITER; it++)
    {
        /* transformación AoS -> SoA */
        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            /*
            Rpixels[i] = ...;
            Gpixels[i] = ...; 
            Bpixels[i] = ...; */
        }

        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            // Ypixels[i] = f(Rpixels[i], Gpixels[i], Bpixels[i]);
            // Cbpixels[i] = ...
            // Crpixels[i] = ...
        }

        /* transformación SoA -> AoS */
        /* COMPLETAR ... */
        #pragma GCC ivdep
        for (int i = 0; i < height*width; i++)
        {
            // = Ypixels[i];
            // = Cbpixels[i];
            // = Crpixels[i];
        }

        dummy(image_in, image_out);
    }

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2YCbCrSOA1");

    free(Rpixels); free(Ypixels);
}

#define BLOCK 64

 /* función que entrelaza la transformación de los datos con los cálculos a realizar.
    De esta forma, en lugar de necesitar nuevas variables
    con **todos** los valores RGB de la imagen en formato SOA,
    solamente son necesarias variables que almacenen **parte** de los valores RGB */
void
RGB2YCbCr_block(image_t * restrict image_in, image_t * restrict image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;
    unsigned char __attribute__((aligned(SIMD_ALIGN))) Rpixels[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) Gpixels[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) Bpixels[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) Ypixels[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) Cbpixels[BLOCK];
    unsigned char __attribute__((aligned(SIMD_ALIGN))) Crpixels[BLOCK];



    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 3;
    image_out->color_space = JCS_YCbCr;

    start_t = get_wall_time();
    for (int it = 0; it < NITER; it++)
    {
        for (int i = 0; i < height*width; i+= BLOCK)
        {
            /* transformación AoS -> SoA */



            #pragma GCC ivdep
            for (int j = 0; j < BLOCK; j++)
            {
                // Rpixels[j] = ...;
                // Gpixels[j] = ...;
                // Bpixels[j] = ...;
            }
            /* conversión RGB -> YbCrCb */
            #pragma GCC ivdep
            for (int j = 0; j < BLOCK; j++)
            {
                // Ypixels[j]  = (unsigned char) (0.5f + ...);
                // Cbpixels[j] = (unsigned char) (0.5f + ...);
                // Crpixels[j] = (unsigned char) (0.5f + ...);
            }
            /* transformación SoA -> AoS */
            #pragma GCC ivdep
            for (int j = 0; j < BLOCK; j++)
            {
                // ... = Ypixels[j];
                // ... = Cbpixels[j];
                // ... = Crpixels[j];
            }
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "RGB2YCbCr_block");
}
//----------------------------------------------------------------------------

static const float
YCbCr2RGB[3][3] = {
   { 1.0,  0.0,     1.4075 },
   { 1.0, -0.3455, -0.7169 },
   { 1.0,  1.7790,  0.0    }
};

static const int
YCbCr2RGB_offset[3][3]  = {
   { 0,    0,  128 },
   { 0,  128,  128 },
   { 0,  128,    0 }
};

//----------------------------------------------------------------------------

void
YCbCr2RGB_conversion(image_t * image_in, image_t * image_out)
{
    double start_t, end_t;
    const int height = image_in->height;
    const int width =  image_in->width;

    if (image_in->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be YCbCr\n");
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
        for (int i=0; i<height*width; i++)
        {
            image_out->pixels[3*i + 0] = (unsigned char)
               (YCbCr2RGB[0][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[0][0]) + 
                YCbCr2RGB[0][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[0][1]) + 
                YCbCr2RGB[0][2]*(image_in->pixels[3*i + 2] - YCbCr2RGB_offset[0][2]));
            image_out->pixels[3*i + 1] = (unsigned char)
               (YCbCr2RGB[1][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[1][0]) + 
                YCbCr2RGB[1][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[1][1]) + 
                YCbCr2RGB[1][2]*(image_in->pixels[3*i + 2] - YCbCr2RGB_offset[1][2]));
            image_out->pixels[3*i + 2] = (unsigned char)
               (YCbCr2RGB[2][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[2][0]) + 
                YCbCr2RGB[2][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[2][1]) + 
                YCbCr2RGB[2][2]*(image_in->pixels[3*i + 2] - YCbCr2RGB_offset[2][2]));
        }
        dummy(image_in, image_out);
    }
    end_t = get_wall_time();
    results(end_t - start_t, height*width, "YCbCr2RGB()");
}
//----------------------------------------------------------------------------
