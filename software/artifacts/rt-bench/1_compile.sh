#!/bin/bash
CC=$(realpath "../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc

make compile-vision
# make compile-isolbench