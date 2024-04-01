/**
 * @file filters.h
 * @ingroup image-filters
 * @brief Collection of the filters functions.
 * @author Denis Hoornaert <denis.hoornaert@tum.de>
 *
 * @copyright (C) 2022 Denis Hoornaert <denis.hoornaert@tum.de>
 * SPDX-License-Identifier: MIT
*/

#ifndef FILTERS_H
#define FILTERS_H

#include "../include/common.h"

/** @brief Function returning as int the maximal value between two floats.
 * @param[in] a First float to compare.
 * @param[in] b Second float to compare.
 * @return Returns an integer version of the biggest float operand.
 */
int fpmax(float a, float b);

/** @brief Function returning as int the minimal value between two floats.
 * @param[in] a First float to compare.
 * @param[in] b Second float to compare.
 * @return Returns an integer version of the smallest float operand.
 */
int fpmin(float a, float b);

/** @brief Function applying sequentially a grayscale and a threshold filtering
 * on the image given in parameter.
 * @param[inout] img Pointer of `bmp_t` on which the filter will be applied.
 */
void threshold(struct bmp_t *img);

/** @brief Function applying a grayscale filter on the image given in paramter.
 * @param[in] img Input image from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 */
void grayscale(struct bmp_t *img, struct bmp_t *out);

/** @brief Function applying a sepia filter on the image given in paramter.
 * @param[in] img Input image from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 */
void sepia(struct bmp_t *img, struct bmp_t *out);

/** @brief Function applying a sobel filter on the image given in paramter.
 * @param[in] img Input image from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 * @param[in] size Kernels size.
 * @param[in] kh Horizontal kernel of size `size` by `size`.
 * @param[in] kv Vertical kernel of size `size` by `size`.
 */
void sobel(struct bmp_t *img, struct bmp_t *out, unsigned size,
	   int kh[size][size], int kv[size][size]);

/** @brief Function applying a sobel filter on the image given in paramter.
 * @param[in] img Input image from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 * @param[out] theta Output the angle gradient.
 * @param[in] size Kernels size.
 * @param[in] kh Horizontal kernel of size `size` by `size`.
 * @param[in] kv Vertical kernel of size `size` by `size`.
 */
void sobel_gradient(struct bmp_t *img, struct bmp_t *out, unsigned size,
		    int kh[size][size], int kv[size][size], float **theta);

/** @brief Function applying a gaussian noise filter with kernel size of 3x3 on 
 * the image given in paramter.
 * @param[in] img Input image from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 * @param[in] size Kernal size.
 * @param[in] conv Convolution kernel of size `size` by `size`.
 */
void gaussian_noise(struct bmp_t *img, struct bmp_t *out, unsigned size,
		    float conv[size][size]);

/** @brief Perform max suppression on sobel image with its accompanying gradient.
 * @param[in] img Image input from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 * @param[in] theta Output the angle gradient.
 * @param[out] max Maximal value in `out`.
 */
void non_max_suppression(struct bmp_t *img, struct bmp_t *out, float **theta,
			 uint8_t *max);

/** @brief Apply double threshold filtering on input image
 * @param[inout] img Image input from which the data is read.
 * @param[in] max Maximal value in `img`.
 */
void double_threshold(struct bmp_t *img, uint8_t *max);

/** @brief Highlights edges in input image.
 * @param[in] img Image input from which the data is read.
 * @param[out] out Output image in which the filtered image is stored.
 */
void edge_tracking(struct bmp_t *img, struct bmp_t *out);

#endif /* FILTERS_H */
