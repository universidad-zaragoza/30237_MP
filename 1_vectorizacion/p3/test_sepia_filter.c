/* Basado en código descargado en:
 * http://www.cim.mcgill.ca/~junaed/libjpeg.php */
/* Adaptado: Jesús Alastruey Benedé
 * v2.0, 2-marzo-2021 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include "jpeg_handler.h"
#include "include/jpeglib.h"
#include "sepia_filter.h"
#include "misc.h"

//----------------------------------------------------------------------------

#define STRLEN 256

char in_filename[STRLEN] = "images/2013-10-02_Campo_Base_Annapurna.jpg";
char out_filename[STRLEN] = { 0 };

static int reference = 0;
static int fast = 0;
static int verbose = 0;
static int conv_type = 0;

static const char *optString = "i:o:c:fvrh?";

static const struct option longOpts[] =
{
  {"input_filename",    required_argument,  NULL,   'i'},
  {"output_filename",   required_argument,  NULL,   'o'},
  {"conversion_type",   required_argument,  NULL,   'c'},
  {"reference",         no_argument,        NULL,   'r'},
  {"fast",              no_argument,        NULL,   'v'},
  {"verbose",           no_argument,        NULL,   'v'},
  {"help",              no_argument,        NULL,   'h'},
  {NULL,                0,                  NULL,    0}
};
//----------------------------------------------------------------------------

static struct option_help {
  const char *long_opt, *short_opt, *desc;
} opts_help[] = {
  { "--input_filename", "-i",
    "input filename" },
  { "--output_filename", "-o",
    "output filename" },
  { "--conversion_type", "-c",
    "0: sepiaf_roundf0, 1: sepiaf_roundf1, 2: sepiaf_cast0, 3: sepiaf_cast1, 4: sepiaf_cast2, 6: sepiaf_SOA0, 7: sepiaf_SOA1, 8: sepiaf_block [default = 0]" },
//    "0: YCbCr2rgb, 1: YCbCr2gray, 2: rgb2gray, 3: rgb2YCbCr [default = 0]" },
  { "--reference", "-r",
    "write reference image [default = no]" },
  { "--fast", "-f",
    "do not run checks [default = yes]" },
  { "--verbose", "-v",
    "generate ppm images [default = no]" },
  { "--help", "-h",
    "Show program usage"},
  { NULL, NULL, NULL }
};
//----------------------------------------------------------------------------

static void
show_usage(char *name, int exit_code)
{
  struct option_help *h;

  printf("usage: %s options\n", name);
  for (h = opts_help; h->long_opt; h++)
  {
    printf(" %s, %s\n ", h->short_opt, h->long_opt);
    printf("    %s\n", h->desc);
  }
  printf("Example:\n");
  printf("  ./test -i images/.jpg -o images/.jpg\n");

  exit(exit_code);
}
//----------------------------------------------------------------------------

static char *
remove_four(char *dst, const char *filename)
{
    size_t len = strlen(filename);
    memcpy(dst, filename, len-4);
    dst[len - 4] = 0;
    return dst;
}
//----------------------------------------------------------------------------
int
check_conversion_color(char *base_filename, char *id_string,
                       image_t *image_out)
{
    /* structs to store raw, uncompressed images and its properties (size, channels ...) */
    image_t image_ref, image_dif;
    int n;
    char dif_filename[STRLEN+16] = { 0 };
    char ref_filename[STRLEN+16] = { 0 };

    if (fast == 1) return 0;

    /* ********************************* */
    /* allocate memory to hold reference and diff images */
    image_ref.pixels = (unsigned char*) malloc(3*image_out->width*image_out->height);
    image_ref.width  = image_out->width;
    image_ref.height = image_out->height;    

    image_dif.pixels = (unsigned char*) malloc(3*image_out->width*image_out->height);
    image_dif.width  = image_out->width;
    image_dif.height = image_out->height;

    /* read reference image */
    snprintf(ref_filename, sizeof(ref_filename), "%s_sepia_ref.ppm", base_filename);
    read_PPM(ref_filename, &image_ref, 6);

    n = cmpColor(image_out, &image_ref, &image_dif);
    if (n > 0)
    {
        if (verbose)
        {
            /* write diff pixel values to ppm image */
            snprintf(dif_filename, sizeof(dif_filename), "%s_%s_dif.ppm", base_filename, id_string);
            write_PPM(dif_filename, &image_dif, 6);
        }

        /* scale dif image to magnify errors */
        // scale_gray(image_dif, image_out);
        snprintf(dif_filename, sizeof(dif_filename), "%s_%s_dif.jpg", base_filename, id_string);
        // n = write_jpeg_file(dif_filename, image_out);
        image_dif.color_space = JCS_RGB;
        n = write_jpeg_file(dif_filename, &image_dif);
        if (n < 0) exit(-1);
    }
    return 0;
}
//----------------------------------------------------------------------------

static int
test_convert_sepia()
{
    /* structs to store raw, uncompressed images and its properties (size, channels ...) */
    image_t image_RGB, image_sepia;
    int n;
    char basename[STRLEN] = { 0 };
    char tmp_filename[STRLEN+16] = { 0 };

    /* open jpeg image */
    n = read_jpeg_file(in_filename, &image_RGB);
    if (n < 0) exit(-1);

    printf("                     Time\n");
    printf("        función      (ms)    ns/px    Gpixels/s\n");

    /* remove the last four letters of in_filename */
    remove_four(basename, in_filename);

    /* dump RGB pixel values to file */
    if (verbose)
    {
        snprintf(tmp_filename, sizeof(tmp_filename), "%s_RGB.ppm", basename);
        write_PPM(tmp_filename, &image_RGB, 6);
    }

    /* ********************************* */
    /* RGB -> sepia */
    /* allocate memory to hold the converted image */
    image_sepia.pixels = (unsigned char*) malloc(3*image_RGB.width*image_RGB.height);

    /* convert from RGB to sepia */
    switch (conv_type)
    {
        case 0: sepia_filter_roundf0(&image_RGB, &image_sepia);
                break;
        case 1: sepia_filter_roundf1(&image_RGB, &image_sepia);
                break;
        case 2: sepia_filter_cast0(&image_RGB, &image_sepia);
                break;
        case 3: sepia_filter_cast1(&image_RGB, &image_sepia);
                break;
        case 4: sepia_filter_cast2(&image_RGB, &image_sepia);
                break;
        case 5: sepia_filter_cast_esc(&image_RGB, &image_sepia);
                break;
        case 6: sepia_filter_SOA0(&image_RGB, &image_sepia);
                break;
        case 7: sepia_filter_SOA1(&image_RGB, &image_sepia);
                break;
        case 8: sepia_filter_block(&image_RGB, &image_sepia);
                break;
        case 9: sepia_filter_roundf0(&image_RGB, &image_sepia);
                sepia_filter_roundf1(&image_RGB, &image_sepia);
                sepia_filter_cast0(&image_RGB, &image_sepia);
                sepia_filter_cast1(&image_RGB, &image_sepia);
                sepia_filter_cast2(&image_RGB, &image_sepia);
                sepia_filter_cast_esc(&image_RGB, &image_sepia);
                sepia_filter_SOA0(&image_RGB, &image_sepia);
                sepia_filter_SOA1(&image_RGB, &image_sepia);
                sepia_filter_block(&image_RGB, &image_sepia);
                break;
        default: sepia_filter_roundf0(&image_RGB, &image_sepia);
    }

    /* write sepia image to file */
    snprintf(tmp_filename, sizeof(tmp_filename), "%s_sepia.jpg", basename);
    n = write_jpeg_file(tmp_filename, &image_sepia);
    if (n < 0) exit(-1);

    if (reference)
    {
        /* reference image written in jpg and ppm formats */
        snprintf(tmp_filename, sizeof(tmp_filename), "%s_sepia_ref.jpg", basename);
        n = write_jpeg_file(tmp_filename, &image_sepia);

        /* comparison of images in jpg format does not work */
        snprintf(tmp_filename, sizeof(tmp_filename), "%s_sepia_ref.ppm", basename);
        write_PPM(tmp_filename, &image_sepia, 6);
    }
    else
    {
        /* verify conversion */
        if (conv_type != 9) check_conversion_color(basename, "sepia", &image_sepia);
    }   
    return 0;
}
//----------------------------------------------------------------------------

int
main(int argc, char *argv[])
{
    int n, option;

    while(1)
    {
        option = getopt_long(argc, argv, optString, longOpts, NULL /* &longIndex */);
        if (option == -1) break;

        switch(option)
        {
            case 'i': /* path to the input file */
                n = snprintf(in_filename, sizeof(in_filename), "%s", optarg);
                if (n == sizeof(in_filename) - 1)
                {
                  printf("Too long input filename\n");
                  exit(0);
			    }
                break;
    
            case 'o': /* path to the output file */
                n = snprintf(out_filename, sizeof(out_filename), "%s", optarg);
                if (n == sizeof(out_filename) - 1)
                {
                  printf("Too long output filename\n");
                  exit(0);
			    }
                break;
    
            case 'c': /* conversion type */
                conv_type = strtol(optarg, NULL, 10);
                break;

            case 'r':
                reference = 1;
                break;  

            case 'f':
                fast = 1;
                break;

            case 'v':
                verbose = 1;
                break;
    
            case 'h':
                show_usage(argv[0], 0);
                break;
    
            default:
                show_usage(argv[0], 1);
        }
    }

    test_convert_sepia();
    exit(0);
}
