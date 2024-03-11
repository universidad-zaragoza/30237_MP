/* Jesús Alastruey Benedé
 * v1.0, 6-marzo-2017
 * v2.0, 3-marzo-2021
 */

#ifndef CONVERT2SEPIA_GUARD

#include "jpeg_handler.h"

#define SIMD_ALIGN 32

void
sepia_filter_roundf0(image_t * image_in, image_t * image_out);

void
sepia_filter_roundf1(image_t * image_in, image_t * image_out);

void
sepia_filter_cast0(image_t * restrict image_in, image_t * restrict image_out);

void
sepia_filter_cast1(image_t * restrict image_in, image_t * restrict image_out);

void
sepia_filter_cast2(image_t * restrict image_in, image_t * restrict image_out);

void
sepia_filter_cast_esc(image_t * restrict image_in, image_t * restrict image_out);

void
sepia_filter_SOA0(image_t * restrict image_in, image_t * restrict image_out);

void
sepia_filter_SOA1(image_t * restrict image_in, image_t * restrict image_out);

void
sepia_filter_block(image_t * restrict image_in, image_t * restrict image_out);

#endif
