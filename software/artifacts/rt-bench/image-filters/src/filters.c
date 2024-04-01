/**
 * @file filters.c
 * @ingroup image-filters
 * @author Denis Hoornaert <denis.hoornaert@tum.de>
 * @brief Collection of the filters logic.
 *
 * This allows the benchmark to be run periodically, by re-running only the
 * execution portion.
 *
 * @copyright (C) 2022 Denis Hoornaert <denis.hoornaert@tum.de>
 * SPDX-License-Identifier: MIT
 *
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

#include "../include/filters.h"

int fpmax(float a, float b) {return (a > b)? a : b;}
int fpmin(float a, float b) {return (a < b)? a : b;}

void threshold(struct bmp_t* img) {
    for (size_t h = 0; h < img->height; h++)
        for (size_t r = 0; r < img->width*img->depth; r++)
            img->data[h][r] = (img->data[h][r] >= 128)? 255 : 0;
}

void grayscale(struct bmp_t* img, struct bmp_t* out) {
    for (size_t h = 0; h < img->height; h++) {
        for (size_t p = 0; p < img->width*img->depth; p+=img->depth) {
            float weighted_sum = ((unsigned char)img->data[h][p+2]*0.2989f) + ((unsigned char)img->data[h][p+1]*0.5870f) + ((unsigned char)img->data[h][p+0]*0.1140f);
            char gray = (weighted_sum >= 255)? 255 : weighted_sum;
            out->data[h][p+0] = gray;
            out->data[h][p+1] = gray;
            out->data[h][p+2] = gray;
        }
    }
}

void sepia(struct bmp_t* img, struct bmp_t* out) {
    for (size_t h = 0; h < img->height; h++) {
        for (size_t p = 0; p < img->width*img->depth; p+=img->depth) {
            float r = (unsigned char)img->data[h][p+2];
            float g = (unsigned char)img->data[h][p+1];
            float b = (unsigned char)img->data[h][p+0];
            float tr = (r*0.393f) + (g*0.769f) + (b*0.189f);
            float tg = (r*0.349f) + (g*0.686f) + (b*0.168f);
            float tb = (r*0.272f) + (g*0.534f) + (b*0.131f);
            out->data[h][p+2] = (tr >= 255)? 255 : ((unsigned)tr)&0x000000ff;
            out->data[h][p+1] = (tg >= 255)? 255 : ((unsigned)tg)&0x000000ff;
            out->data[h][p+0] = (tb >= 255)? 255 : ((unsigned)tb)&0x000000ff;
        }
    }
}

void sobel(struct bmp_t* img, struct bmp_t* out, unsigned size, int kh[size][size], int kv[size][size]) {
    unsigned half_size = size/2;
    for (size_t h = half_size; h < img->height-half_size; h++) {
        for (size_t p = img->depth*half_size; p < (img->width-half_size)*img->depth; p+=img->depth) {
	    int gx = 0;
            int gy = 0;
            for (size_t i = 0; i < size; i++) {
                for (size_t j = 0; j < size; j++) {
                    gx += img->data[h+(i-half_size)][p+((j-half_size)*img->depth)]*kh[i][j];
                    gy += img->data[h+(i-half_size)][p+((j-half_size)*img->depth)]*kv[i][j];
                }
            }
            char color = fpmin(fpmax(sqrt(pow(gx, 2)+pow(gy, 2)), 0), 255);
            out->data[h][p+2] = color;
            out->data[h][p+1] = color;
            out->data[h][p+0] = color;
        }
    }
}

void sobel_gradient(struct bmp_t* img, struct bmp_t* out, unsigned size, int kh[size][size], int kv[size][size], float** theta) {
    unsigned half_size = size/2;
    for (size_t h = half_size; h < img->height-half_size; h++) {
	size_t r = half_size;
        for (size_t p = img->depth*half_size; p < (img->width-half_size)*img->depth; p+=img->depth) {
            int gx = 0;
            int gy = 0;
            for (size_t i = 0; i < size; i++) {
                for (size_t j = 0; j < size; j++) {
                    gx += img->data[h+(i-half_size)][p+((j-half_size)*img->depth)]*kh[i][j];
                    gy += img->data[h+(i-half_size)][p+((j-half_size)*img->depth)]*kv[i][j];
                }
            }
            char color = fpmin(fpmax(sqrt(pow(gx, 2)+pow(gy, 2)), 0), 255);
            out->data[h][p+2] = color;
            out->data[h][p+1] = color;
            out->data[h][p+0] = color;
	    theta[h][r] = atan((double)gx/(double)gy);
	    r++;
        }
    }
}

void gaussian_noise(struct bmp_t* img, struct bmp_t* out, unsigned size, float conv[size][size]) {
    unsigned half_size = size/2;
    for (size_t h = half_size; h < img->height-half_size; h++) {
        for (size_t r = img->depth*half_size; r < (img->width-half_size)*img->depth; r++) {
            int res = 0;
            for (size_t i = 0; i < size; i++) {
                for (size_t j = 0; j < size; j++) {
                    res += img->data[h+(i-half_size)][r+((j-half_size)*img->depth)]*conv[i][j];
                }
            }
            out->data[h][r] = fpmin(fpmax(res, 0), 255);
        }
    }
}

void non_max_suppression(struct bmp_t* img, struct bmp_t* out, float** theta, uint8_t* max) {
    for (size_t h = 1; h < img->height-1; h++) {
        for (size_t p = 1; p < img->width-1; p++) {
	    // If negative, add PI
	    theta[h][p] = (theta[h][p] > 0.0)? theta[h][p] : theta[h][p]+M_PI;
	    // Analyse
	    uint8_t components[2] = {255, 255};
	    if ((0 <= theta[h][p]) & (theta[h][p] < M_PI/8.0f)) {
	        components[0] = img->data[h][(p+1)*img->depth];
		components[1] = img->data[h][(p-1)*img->depth];
	    }
	    else if ((1*M_PI/8.0f <= theta[h][p]) & (theta[h][p] < 3*M_PI/8.0f)) {
	        components[0] = img->data[h+1][(p-1)*img->depth];
                components[1] = img->data[h-1][(p+1)*img->depth];
	    }
	    else if ((3*M_PI/8.0f <= theta[h][p]) & (theta[h][p] < 5*M_PI/8.0f)) {
	        components[0] = img->data[h+1][p*img->depth];
                components[1] = img->data[h-1][p*img->depth];
	    }
	    else if ((5*M_PI/8.0f <= theta[h][p]) & (theta[h][p] < 7*M_PI/8.0f)) {
	        components[0] = img->data[h-1][(p-1)*img->depth];
                components[1] = img->data[h+1][(p+1)*img->depth];
	    }
	    else if ((7*M_PI/8.0f <= theta[h][p]) & (theta[h][p] < M_PI)) {
	        components[0] = img->data[h][(p+1)*img->depth];
                components[1] = img->data[h][(p-1)*img->depth];
	    }
	    // Write in image
	    if ((img->data[h][p*img->depth] >= components[0]) & (img->data[h][p*img->depth] >= components[1])) {
	        out->data[h][(p*img->depth)+2] = img->data[h][(p*img->depth)+2];
		out->data[h][(p*img->depth)+1] = img->data[h][(p*img->depth)+1];
		out->data[h][(p*img->depth)+0] = img->data[h][(p*img->depth)+0];
	    }
	    else {
		out->data[h][(p*img->depth)+2] = 0;
                out->data[h][(p*img->depth)+1] = 0;
                out->data[h][(p*img->depth)+0] = 0;
	    }
	    // Look for max value
	    if ((*max) < out->data[h][p*img->depth])
		(*max) = out->data[h][p*img->depth];
	}
    }
}

void double_threshold(struct bmp_t* img, uint8_t* max) {
    // Threshold
    float strong_threshold = (*max)*0.225f;
    float medium_threshold = strong_threshold*0.05f;
    // Filter
    for (size_t h = 0; h < img->height; h++) {
    	for (size_t r = 0; r < img->width*img->depth; r++) {
	    if (img->data[h][r] >= strong_threshold)
		img->data[h][r] = 255;
	    else if (img->data[h][r] < medium_threshold)
		img->data[h][r] = 0;
	    else
		img->data[h][r] = 25;
	}
    }
}

void edge_tracking(struct bmp_t* img, struct bmp_t* out) {
    unsigned size = 3;
    unsigned half_size = size/2;
    // Filter
    for (size_t h = 1; h < img->height-1; h++) {
        for (size_t p = img->depth; p < (img->width-1)*img->depth; p+=img->depth) {
	    uint8_t neighbourhood = 0;
	    for (size_t i = 0; (i < size) & (neighbourhood != 255); i++) {
                for (size_t j = 0; (j < size) & (neighbourhood != 255); j++) {
		    if (i != j) {
                        neighbourhood = img->data[h+(i-half_size)][p+((j-half_size)*img->depth)];
		    }
                }
            }
            out->data[h][p+2] = (neighbourhood == 255)? 255 : 0;
	    out->data[h][p+1] = (neighbourhood == 255)? 255 : 0;
	    out->data[h][p+0] = (neighbourhood == 255)? 255 : 0;
	}
    }
}
