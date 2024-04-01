/**
 * @file gaussian_noise7.c
 * @defgroup gaussian_noise Gaussian_noise7
 * @ingroup image-filters
 * @brief Benchmark running gaussian noise filtering with 7x7 kernel size on BMP image.
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
	float conv[7][7] = {
		{1.960000e-05, 2.393000e-04, 1.072400e-03, 1.768100e-03, 1.072400e-03, 2.393000e-04, 1.960000e-05},
		{2.393000e-04, 2.915000e-03, 1.306420e-02, 2.153930e-02, 1.306420e-02, 2.915000e-03, 2.393000e-04},
		{1.072400e-03, 1.306420e-02, 5.854980e-02, 9.653240e-02, 5.854980e-02, 1.306420e-02, 1.072400e-03},
		{1.768100e-03, 2.153930e-02, 9.653240e-02, 1.591549e-01, 9.653240e-02, 2.153930e-02, 1.768100e-03},
		{1.072400e-03, 1.306420e-02, 5.854980e-02, 9.653240e-02, 5.854980e-02, 1.306420e-02, 1.072400e-03},
		{2.393000e-04, 2.915000e-03, 1.306420e-02, 2.153930e-02, 1.306420e-02, 2.915000e-03, 2.393000e-04},
		{1.960000e-05, 2.393000e-04, 1.072400e-03, 1.768100e-03, 1.072400e-03, 2.393000e-04, 1.960000e-05}
	};
	gaussian_noise(&source, &target, 7, conv);
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
