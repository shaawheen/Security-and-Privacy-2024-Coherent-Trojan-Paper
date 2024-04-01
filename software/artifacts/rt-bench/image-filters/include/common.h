/**
 * @file common.h
 * @ingroup image-filters
 * @brief All BMP-related manipulation functions and struct.
 * @author Denis Hoornaert <denis.hoornaert@tum.de>
 *
 * @copyright (C) 2022 Denis Hoornaert <denis.hoornaert@tum.de>
 * SPDX-License-Identifier: MIT
*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

#ifndef COMMON_H
#define COMMON_H

/** @brief Struct representing the useful data to represent a BMP image in memory.
 * @details
 * Is used to store relevant data (e.g., height, width) and other raw type of data
 * to be used down the line by the filters and BMP manipulations.
 */
struct bmp_t {
	uint32_t file_size; ///< The size of the BMP file read in bytes
	uint32_t data_offset; ///< The offset in bytes of where the data start in the file @todo: useful?
	uint32_t width; ///< The width in pixels of the image
	uint32_t height; ///, The height in pixels of the image
	uint16_t depth; ///< The size in bytes of each pixel
	uint8_t *header; ///< Raw BMP header (fixed in format definition)
	uint8_t *header_ext; ///< RAW BMP header extension (dynamic, input dependent)
	uint8_t **data; ///< Payload storing the image's pixels
};

/** @brief Function in charge of reading a BMP file and populating the `bmp_t` struct 
 * accordingly given a file name.
 * @param[in] file The file name (path included) to the BMP image to read.
 */
struct bmp_t readBMP(const char *file);

/** @brief Function copying the content of one `bmp_t` struct in another.
 * @param[in] img The source image to copy from.
 * @param[out] out The destination struct to copy to.
 */
void copyBMP(struct bmp_t *img, struct bmp_t *out);

/** @brief Function writing the content of a `bmp_t` struct into a BMP image file.
 * @param[in] file The file name (path included) to the BMP image to write.
 * @param[in] img The source image content to write in the file.
 */
void writeBMP(const char *file, struct bmp_t img);

/** @brief Function freeing the dynamically allocated memory used by the `bmp_t` struct.
 * @param[in] img The `bmp_t` struct to free memory from.
 */
void freeBMP(struct bmp_t *img);

#endif /* COMMON_H */
