#ifndef JPEG_HANDLER_H
#define JPEG_HANDLER_H

#include <stdio.h>
#include <stdlib.h>
#include "include/jpeglib.h"


/* estructura para almacenar una imagen */
typedef struct image_s {
    unsigned char * pixels;
    int width;
    int height;
    int bytes_per_pixel;    /* 3 for RGB, 1 for GRAYSCALE images */
    int color_space;        /* JCS_RGB for RGB, JCS_GRAYSCALE for grayscale images */
} image_t;

/**
 * read_jpeg_file Reads from a jpeg file on disk specified by filename and saves into the 
 * raw_image buffer in an uncompressed format.
 * 
 * \returns positive integer if successful, -1 otherwise
 * \param *filename char string specifying the file name to read from
 *
 */
int
read_jpeg_file(char *filename, image_t *image);

/**
 * write_jpeg_file Writes the raw image data stored in the raw_image buffer
 * to a jpeg image with default compression and smoothing options in the file
 * specified by *filename.
 *
 * \returns positive integer if successful, -1 otherwise
 * \param *filename char string specifying the file name to save to
 *
 */
int
write_jpeg_file(char *filename, image_t *image);


#endif // JPEG_HANDLER_H
