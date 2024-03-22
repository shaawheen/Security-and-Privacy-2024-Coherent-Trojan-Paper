#!/bin/bash
ROOT_DIR=$(realpath "../../../")
CC=${ROOT_DIR}/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc
OBJUMP=${ROOT_DIR}/build_toolchain/bin/aarch64-buildroot-linux-gnu-objdump

$CC main.c -o gain_root_priv 


