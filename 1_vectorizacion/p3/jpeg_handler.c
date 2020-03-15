/* Basado en código descargado en:
 * http://www.cim.mcgill.ca/~junaed/libjpeg.php */
/* Adaptado: Jesús Alastruey Benedé
 * 18-marzo-2016 */

#include <stdio.h>
#include <stdlib.h>
#include "jpeg_handler.h"
#include "include/jpeglib.h"

/* Known color spaces (from jpeglib.h) */
const char *color_space_str[8] = {
	"JCS_UNKNOWN",    /* error/unspecified */
	"JCS_GRAYSCALE",  /* monochrome */
	"JCS_RGB",		  /* red/green/blue, standard RGB (sRGB) */
	"JCS_YCbCr",	  /* Y/Cb/Cr (also known as YUV), standard YCC */
	"JCS_CMYK",		  /* C/M/Y/K */
	"JCS_YCCK",		  /* Y/Cb/Cr/K */
	"JCS_BG_RGB",	  /* big gamut red/green/blue, bg-sRGB */
	"JCS_BG_YCC"	  /* big gamut Y/Cb/Cr, bg-sYCC */
};


/**
 * read_jpeg_file Reads from a jpeg file on disk specified by filename and saves into the 
 * raw_image buffer in an uncompressed format.
 * 
 * \returns positive integer if successful, -1 otherwise
 * \param *filename char string specifying the file name to read from
 *
 */

int
read_jpeg_file(char *filename, image_t *image)
{
    /* these are standard libjpeg structures for reading (decompression) */
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    /* libjpeg data structure for storing one row, that is, scanline of an image */
    JSAMPROW row_pointer[1];
    /* pointer to store raw, uncompressd image */
    //unsigned char *raw_image = NULL;
    FILE *infile = fopen(filename, "rb");
    unsigned long location = 0;
    unsigned int i = 0;
    
    if (!infile)
    {
        printf("ERROR: no ha podido abrirse el fichero con la imagen\n");
        return(-1);
    }
    // printf("Leyendo imagen %s ...", filename);

    /* here we set up the standard libjpeg error handler */
    cinfo.err = jpeg_std_error(&jerr);

    /* setup decompression process and source, then read JPEG header */
    jpeg_create_decompress(&cinfo);

    /* this makes the library read from infile */
    jpeg_stdio_src(&cinfo, infile);

    /* reading the image header which contains image information */
    jpeg_read_header(&cinfo, TRUE);

    /* fill struct fields */
    image->width  = cinfo.image_width;
    image->height = cinfo.image_height;
    image->bytes_per_pixel = cinfo.num_components;
    // image->color_space = cinfo.jpeg_color_space;
    // image->color_space = JCS_RGB;

    /* Start decompression jpeg here */
    jpeg_start_decompress(&cinfo);

    /* allocate memory to hold the uncompressed image */
    image->pixels = (unsigned char*) malloc(cinfo.output_width*cinfo.output_height*cinfo.num_components);

    /* now actually read the jpeg into the raw buffer */
    row_pointer[0] = (unsigned char *) malloc(cinfo.output_width*cinfo.num_components);

    /* read one scan line at a time */
    while (cinfo.output_scanline < cinfo.image_height)
    {
        jpeg_read_scanlines(&cinfo, row_pointer, 1);
        for (i=0; i < cinfo.image_width*cinfo.num_components; i++)
            image->pixels[location++] = row_pointer[0][i];
    }

    /* wrap up decompression, destroy objects, free pointers and close open files */
    jpeg_finish_decompress(&cinfo);
    jpeg_destroy_decompress(&cinfo);
    free(row_pointer[0]);
    fclose(infile);

    // printf(" OK\n");

    /* Uncomment the following to output image information, if needed. */
#if 0
    printf( "------------------\n" );
    printf( "JPEG File Information: \n" );
    printf( "Image width and height: %d x %d pixels.\n", cinfo.image_width, cinfo.image_height);
    printf( "Color components per pixel: %d.\n", cinfo.num_components);
    // printf( "Color space: %d (%s)\n", cinfo.jpeg_color_space, color_space_str[cinfo.jpeg_color_space]);
    printf( "------------------\n\n" );
#endif

    /* yup, we succeeded! */
    return(1);
}

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
write_jpeg_file(char *filename, image_t *image)
{
    struct jpeg_compress_struct cinfo;
    struct jpeg_error_mgr jerr;
    
    /* this is a pointer to one row of image data */
    JSAMPROW row_pointer[1];
    FILE *outfile = fopen(filename, "wb");
    
    // printf("Escribiendo imagen %s ...", filename);
    if (!outfile)
    {
        printf("ERROR: no se ha indicado fichero de salida\n");
        // printf("ERROR\n");
        return -1;
    }
    cinfo.err = jpeg_std_error(&jerr);
    jpeg_create_compress(&cinfo);
    jpeg_stdio_dest(&cinfo, outfile);

    /* Setting the parameters of the output file here */
    cinfo.image_width = image->width;   
    cinfo.image_height = image->height;
    cinfo.input_components = image->bytes_per_pixel;
    cinfo.in_color_space = image->color_space;
        
    /* default compression parameters, we shouldn't be worried about these */
    jpeg_set_defaults(&cinfo);

    /* Now do the compression .. */
    jpeg_start_compress(&cinfo, TRUE);

    /* like reading a file, this time write one row at a time */
    while (cinfo.next_scanline < cinfo.image_height)
    {
        row_pointer[0] = &image->pixels[cinfo.next_scanline * cinfo.image_width *  cinfo.input_components];
        jpeg_write_scanlines(&cinfo, row_pointer, 1);
    }

    /* similar to read file, clean up after we're done compressing */
    jpeg_finish_compress(&cinfo);
    jpeg_destroy_compress(&cinfo);
    fclose(outfile);

    //printf(" OK\n");

    /* success code is 1! */
    return 1;
}
