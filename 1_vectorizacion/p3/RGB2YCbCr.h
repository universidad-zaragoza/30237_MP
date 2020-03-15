/* Jesús Alastruey Benedé
 * v1.1, 13-marzo-2020
 */

#ifndef CONVERTRGB2YCBCR_GUARD

#include "jpeg_handler.h"

#define SIMD_ALIGN 32

void
RGB2YCbCr_roundf0(image_t * image_in, image_t * image_out);

void
RGB2YCbCr_roundf1(image_t * image_in, image_t * image_out);

void
RGB2YCbCr_cast0(image_t * restrict image_in, image_t * restrict image_out);

void
RGB2YCbCr_cast1(image_t * restrict image_in, image_t * restrict image_out);

void
RGB2YCbCr_cast2(image_t * restrict image_in, image_t * restrict image_out);

void
RGB2YCbCr_cast_esc(image_t * restrict image_in, image_t * restrict image_out);

void
RGB2YCbCr_SOA0(image_t * restrict image_in, image_t * restrict image_out);

void
RGB2YCbCr_SOA1(image_t * restrict image_in, image_t * restrict image_out);

void
RGB2YCbCr_block(image_t * restrict image_in, image_t * restrict image_out);

void
YCbCr2RGB_conversion(image_t * image_in, image_t * image_out);

#endif
