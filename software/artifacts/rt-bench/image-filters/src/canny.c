/**
 * @file canny.c
 * @defgroup canny Canny
 * @ingroup image-filters
 * @brief Benchmark running canny filtering on BMP image.
 * @author Denis Hoornaert <denis.hoornaert@tum.de>
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * This allows the benchmark to be run periodically, by re-running only the
 * execution portion.
 *
 * @copyright (C) 2022 Denis Hoornaert <denis.hoornaert@tum.de>
 * SPDX-License-Identifier: MIT
 *
 */

#include "../include/common.h"
#include "../include/filters.h"

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/// Struct storing parsed BMP image as read from the file.
struct bmp_t source;

/// Struct storing an intermediate rpresentation of the image under processing.
struct bmp_t intermediate;

/// Struct storing the outproduct of the filtering on 'source'.
struct bmp_t target;

/// Struct stores angle gradient.
float** theta;

/**
 * @brief Reads content of specified BMP file and create a copy.
 * @param[in] parameters_num Number of parameters passed, should be 2.
 * @param[in] parameters The list of passed parameters. First element indicates
 * the BMP file to read and parse.
 * @details
 * The required parameters array is documented in `usage()`, and can be brought
 * up by having "-h" in `parameters`.
 * @returns `0` on success, `-1` on error, setting errno.
 */
int benchmark_init(int parameters_num, void **parameters)
{
	if (parameters_num < 2)
		return -1;

	// BMP
	source = readBMP(parameters[0]);
	copyBMP(&source, &target);
	copyBMP(&source, &intermediate);
	// Angle gradient
	theta = (float**)malloc(source.height*sizeof(float*));
	for (size_t h = 0; h < source.height; h++)
		theta[h] = (float*)malloc(source.width*sizeof(float));

	return 0;
}

/**
 * @brief Applies sobel filter on the 'source', writing the outcome in 'target'.
 * @param[in] parameters_num Number of passed parameters, ignored.
 * @param[in] parameters The list of passed parameters, ignored.
 * @details
 * This function applies the grayscale filtering on the 'source' image.
 */
void benchmark_execution(int parameters_num, void **parameters)
{
	uint8_t max = 0;
	float conv[5][5] = {
		{0.00291502f, 0.01306423f, 0.02153928f, 0.01306423f, 0.00291502f},
		{0.01306423f, 0.05854983f, 0.09653235f, 0.05854983f, 0.01306423f},
		{0.02153928f, 0.09653235f, 0.15915494f, 0.09653235f, 0.02153928f},
		{0.01306423f, 0.05854983f, 0.09653235f, 0.05854983f, 0.01306423f},
		{0.00291502f, 0.01306423f, 0.02153928f, 0.01306423f, 0.00291502f}
	};
	int kh[3][3] = {
                {-1, -2, -1},
                { 0,  0,  0},
                { 1,  2,  1}
        };
        int kv[3][3] = {
                {-1,  0,  1},
                {-2,  0,  2},
                {-1,  0,  1}
        };

	grayscale(&source, &intermediate);
	gaussian_noise(&intermediate, &target, 5, conv);
	sobel_gradient(&target, &intermediate, 3, kh, kv, theta);
	non_max_suppression(&intermediate, &target, theta, &max);
	double_threshold(&target, &max);
	edge_tracking(&target, &intermediate);
}

/**
 * @brief Will revert what `benchmark_init()` has done to initialize the
 * benchmark.
 * @param[in] parameters_num should be equal to 2.
 * @param[in] parameters the second option is the BMP image to write to.
 * @details Writes the filtered image as a BMP file and frees the data structs allocated.
 */
void benchmark_teardown(int parameters_num, void **parameters)
{
	// BMP
	writeBMP(parameters[1], intermediate);
        freeBMP(&source);
	freeBMP(&target);
	// Angle gradient
	for (size_t h = 0; h < source.height; h++) {
		free(theta[h]);
		theta[h] = NULL;
	}
	free(theta);
	theta = NULL;
}
