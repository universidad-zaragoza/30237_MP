/* Jesús Alastruey Benedé
 * 28-abril-2016
 * updated: 15-mar-2018 */

#ifndef CMP_GUARD
#define CMP_GUARD

#include "jpeg_handler.h"

/* iteraciones para aumentar el tiempo de ejecución */
#define NITER 10
// #define NITER 50

/* return wall time in seconds */
double
get_wall_time();

/* return cpu time in seconds */
double
get_cpu_time();

void
results(double wall_time, int npixels, char *loop);

int
cmpGray(image_t * image_in1, image_t * image_in2, image_t * image_out);

int
cmpColor(image_t * image_in1, image_t * image_in2, image_t * image_out);

int
write_PGM(char *filename, image_t * image);

int
read_PGM(char *filename, image_t * image);

int
write_PPM(char *filename, image_t * image, int format);

int
read_PPM(char *filename, image_t * image, int format);

#endif
