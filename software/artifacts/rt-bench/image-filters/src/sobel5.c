/**
 * @file sobel5.c
 * @defgroup sobel5 Sobel5
 * @ingroup image-filters
 * @brief Benchmark running sobel filtering on BMP image with 5x5 kenel size.
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

/// Struct storing the outproduct of the filtering on 'source'.
struct bmp_t target;

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

	source = readBMP(parameters[0]);
	grayscale(&source, &source);
	copyBMP(&source, &target);

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
	int kh[5][5] = { { 5, 8, 10, 8, 5 },
			 { 4, 10, 20, 10, 4 },
			 { 0, 0, 0, 0, 0 },
			 { -4, -10, -20, -10, -4 },
			 { -5, -8, -10, -8, -5 } };
	int kv[5][5] = { { 5, 4, 0, -4, -5 },
			 { 8, 10, 0, -10, -8 },
			 { 10, 20, 0, -20, -10 },
			 { 8, 10, 0, -10, -8 },
			 { 5, 4, 0, -4, -5 } };
	sobel(&source, &target, 5, kh, kv);
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
	writeBMP(parameters[1], target);
	freeBMP(&source);
	freeBMP(&target);
}
