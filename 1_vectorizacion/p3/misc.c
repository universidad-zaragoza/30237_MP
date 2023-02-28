/* Adaptado: Jesús Alastruey Benedé
 * v1.0, 28-abril-2016
 * v1.1, 24-marzo-2017
 * v1.2, 15-marzo-2018 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <sys/times.h>
#include <malloc.h>

#include "jpeg_handler.h"
#include "include/jpeglib.h"
#include "misc.h"

//----------------------------------------------------------------------------

int dummy(image_t *im1, image_t *im2);

//----------------------------------------------------------------------------

/* inhibimos el inlining
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
//----------------------------------------------------------------------------

/* return cpu time in seconds */
__attribute__ ((noinline))
double
get_cpu_time()
{
    return (double) clock() / CLOCKS_PER_SEC;
}
//----------------------------------------------------------------------------

/* inhibimos el inlining de algunas funciones
 * para que el ensamblador sea más cómodo de leer */
__attribute__ ((noinline))
void results(double wall_time, int npixels, char *loop)
{
  // printf("                  Time\n");
  // printf("función            (s)    ns/pix  Gpixels/s\n");

  printf("%18s  %5.1f    %4.1f       %4.2f \n",
          loop /* nombre del bucle */,
          (1e3)*wall_time/NITER,
          (1e9)*wall_time/(NITER*npixels)  /* ns/pixel */,
          (NITER*npixels)/(wall_time*(1e9)) /* Gpixels por segundo */);
}
//----------------------------------------------------------------------------

int
cmpColor(image_t * image_in1, image_t * image_in2, image_t * image_out)
{
    double start_t, end_t, wall_dif;
    const int height = image_in1->height;
    const int width =  image_in1->width;
    const int color_space =  image_in1->color_space;
    unsigned char * pixels_in1 = image_in1->pixels;
    unsigned char * pixels_in2 = image_in2->pixels;
    unsigned char * pixels_out = image_out->pixels;
    int max_idx, diff;
    char max_diff; /* can be negative */

    if (image_in1->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB or YCbCr\n");
        exit(-1);
    }

    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 3;
    image_out->color_space = color_space;
    // image_out->color_space = JCS_RGB;

    start_t = get_wall_time();
    for (int it = 0; it < NITER/10; it++)
    {
        max_diff = 0; max_idx = -1; diff = 0;
        for (int i = 0; i < 3*height*width; i++)
        {
            pixels_out[i] = abs(pixels_in1[i] - pixels_in2[i]);
            if (pixels_out[i] != 0)
            {
                diff++;
                if (pixels_out[i] > max_diff)
                {
                    max_diff = pixels_out[i];
                    max_idx = i;
                }
            }
        }
        dummy(image_in1, image_out);
    }
    end_t = get_wall_time(); wall_dif = end_t - start_t;
    printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
           "cmpColor",
           wall_dif, wall_dif*1e9/(NITER/10*height*width),
           (NITER/10*height*width)/(1e9*wall_dif), (double) 100.0*diff/(3*height*width),
           max_diff, max_idx, max_diff == 0? "OK":"ERROR");
    printf("        función      Time    ns/px    Gpixels/s  %%diff  max_dif  (max_idx)\n");
    printf("                     (ms)\n");
    return(max_diff);
}
//----------------------------------------------------------------------------

int
cmpGray(image_t * image_in1, image_t * image_in2, image_t * image_out)
{
    double start_t, end_t, wall_dif;
    const int height = image_in1->height;
    const int width =  image_in1->width;
    unsigned char * pixels_in1 = image_in1->pixels;
    unsigned char * pixels_in2 = image_in2->pixels;
    unsigned char * pixels_out = image_out->pixels;
    int max_idx, diff;
    char max_gray_diff; /* can be negative */

    if (image_in1->bytes_per_pixel != 1)
    {
        printf("ERROR: input image has to be GRAY\n");
        exit(-1);
    }
    
    /* fill struct fields */
    image_out->width  = width;
    image_out->height = height;
    image_out->bytes_per_pixel = 1;
    image_out->color_space = JCS_GRAYSCALE;

    start_t = get_wall_time();

    for (int it = 0; it < NITER/10; it++)
    {
        max_gray_diff = 0; max_idx = -1; diff = 0;

        for (int i = 0; i < height*width; i++)
        {
            pixels_out[i] = abs(pixels_in1[i] - pixels_in2[i]);
            if (pixels_out[i] != 0)
            {
                diff++;
                if (pixels_out[i] > max_gray_diff)
                {
                    max_gray_diff = pixels_out[i];
                    max_idx = i;
                }
            }
        }
        dummy(image_in1, image_out);
    }
    end_t = get_wall_time(); wall_dif = end_t - start_t;
    printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n",
           "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
           (NITER*height*width)/(1e9*wall_dif), (double) 100.0*diff/(height*width), max_gray_diff, max_idx);
    printf("        función      Time    ns/px    Gpixels/s  %%diff  max_dif (max_idx)\n");
    printf("                     (ms)\n");
    return(max_gray_diff);
}
//----------------------------------------------------------------------------

int
write_PGM(char *filename, image_t * image)
{
    double start_t, end_t;
    const int height = image->height;
    const int width =  image->width;
    unsigned char * pixels  = image->pixels;

    if (image->bytes_per_pixel != 1)
    {
        printf("ERROR: input image has to be gray\n");
        exit(-1);
    }

    start_t = get_wall_time();

    FILE *outfile = fopen(filename, "w");
    if (!outfile)
    {
        printf("ERROR: no se ha indicado fichero de salida\n");
        return -1;
    }

    /* PGM header */
    fprintf(outfile, "P2 %u %u 255\n", width, height);

    for (int i = 0; i < height*width; i++)
    {
        fprintf(outfile, "%u\n", pixels[i]);
    }

    fclose(outfile);

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "write_PGM");
    printf("\n");
    return 0;
}
//----------------------------------------------------------------------------

// format: 3 -> ascii  (P3 magic number)
// format: 6 -> binary (P6 magic number)
int
write_PPM(char *filename, image_t * image, int format)
{
    double start_t, end_t;
    const int height = image->height;
    const int width =  image->width;
    unsigned char * pixels  = image->pixels;

    if (image->bytes_per_pixel != 3)
    {
        printf("ERROR: input image has to be RGB or YCbCr\n");
        exit(-1);
    }
    if ((format != 3) && (format != 6))
    {
        printf("ERROR: bad format number (3 or 6)\n");
        exit(-1);
    }

    start_t = get_wall_time();

    FILE *outfile = fopen(filename, "w");
    if (!outfile)
    {
        printf("ERROR: no se ha indicado fichero de salida\n");
        return -1;
    }

    /* PPM header */
    fprintf(outfile, "P%u %u %u 255\n", format, width, height);

    if (format == 3)
    {
        for (int i = 0; i < height*width; i++)
        {
            fprintf(outfile, "%u %u %u\n",
                        pixels[3*i+0],
                        pixels[3*i+1],
                        pixels[3*i+2]);
        }
    }
    else
    {
        fwrite(pixels, sizeof(unsigned char), 3*height*width, outfile);
    }
    fclose(outfile);

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "write_PPM");
    printf("\n");
    return 0;
}
//----------------------------------------------------------------------------

int
read_PGM(char *filename, image_t * image)
{
    double start_t, end_t;
    int height = 0, width =  0;
    unsigned char *pixels  = image->pixels;
    char buf[256] = { 0 };

    start_t = get_wall_time();

    FILE *infile = fopen(filename, "r");
    if (!infile)
    {
        printf("ERROR: no se ha encontrado el fichero %s\n", filename);
        exit(-1);
    }
    
    /* PGM header */
    if (fgets(buf, sizeof(buf), infile) == NULL)
    {
        printf("ERROR: PGM image has no header\n");
        exit(-1);
    }
    sscanf(buf, "P2 %u %u 255\n",  &width, &height);
    if ((width != image->width) || (height != image->height))
    {
        printf("ERROR: image has different size than expected: %u x %u instead of %u x %u\n", width, height, image->width, image->height);
        exit(-1);
    }
    
    for (int i=0; i < height*width; i++)
    {
        if (fgets(buf, sizeof(buf), infile) == NULL)
        {
            printf("ERROR: unexpected EOF\n");
            exit(-1);
        }
        sscanf(buf, "%hhu\n", &pixels[i]);
    }

    fclose(infile);

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "read_PGM");
    return 0;
}
//----------------------------------------------------------------------------

// format: 3 -> ascii  (P3 magic number)
// format: 6 -> binary (P6 magic number)
int
read_PPM(char *filename, image_t * image, int format)
{
    double start_t, end_t;
    int n = 0, height = 0, width =  0;
    int img_format = 0;
    unsigned char *pixels  = image->pixels;
    char buf[256] = { 0 };

    start_t = get_wall_time();

    FILE *infile = fopen(filename, "r");
    if (!infile)
    {
        printf("ERROR: no se ha encontrado el fichero %s\n", filename);
        exit(-1);
    }
    if ((format != 3) && (format != 6))
    {
        printf("ERROR: bad format number (3 or 6)\n");
        exit(-1);
    }
    
    /* PPM header */
    if (fgets(buf, sizeof(buf), infile) == NULL)
    {
        printf("ERROR: PPM image has no header\n");
        exit(-1);
    }
    sscanf(buf, "P%u %u %u 255\n", &img_format, &width, &height);
    if (img_format != format)
    {
        printf("ERROR: image has different format (%u) than expected (%u)\n", img_format, format);
        exit(-1);
    }
    if ((width != image->width) || (height != image->height))
    {
        printf("ERROR: image has different size than expected: %u x %u instead of %u x %u\n", width, height, image->width, image->height);
        exit(-1);
    }
    
    if (format == 3)
    {
        for (int i=0; i<height*width; i++)
        {
            if (fgets(buf, sizeof(buf), infile) == NULL)
            {
                printf("ERROR: unexpected EOF\n");
                exit(-1);
            }
            sscanf(buf, "%hhu %hhu %hhu\n",
                    &pixels[3*i+0],
                    &pixels[3*i+1],
                    &pixels[3*i+2]);
        }
    }
    else
    {
        n = fread(pixels, sizeof(unsigned char), 3*height*width, infile);
        if (n == 0) return -1;
    }

    fclose(infile);

    end_t = get_wall_time();
    results(end_t - start_t, height*width, "read_PPM");
    return 0;
}
//----------------------------------------------------------------------------
