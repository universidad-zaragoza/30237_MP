/* Jesús Alastruey Benedé
 * v1.0, 6-marzo-2017
 * v2.0, 3-marzo-2021
 * v2.1, 1-marzo-2022
 */

#ifndef RGB2GRAY_GUARD

#include "jpeg_handler.h"

#define SIMD_ALIGN 32

void
rgb2gray_roundf0(image_t * image_in, image_t * image_out);

void
rgb2gray_roundf1(image_t * image_in, image_t * image_out);

void
rgb2gray_cast0(image_t * restrict image_in, image_t * restrict image_out);

void
rgb2gray_cast1(image_t * restrict image_in, image_t * restrict image_out);

void
rgb2gray_cast2(image_t * restrict image_in, image_t * restrict image_out);

void
rgb2gray_cast_esc(image_t * restrict image_in, image_t * restrict image_out);

void
rgb2gray_SOA0(image_t * restrict image_in, image_t * restrict image_out);

void
rgb2gray_SOA1(image_t * restrict image_in, image_t * restrict image_out);

void
rgb2gray_block(image_t * restrict image_in, image_t * restrict image_out);

#endif
