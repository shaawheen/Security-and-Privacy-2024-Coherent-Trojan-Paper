#!/bin/bash
CC=$(realpath "../../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc
OBJUMP=$(realpath "../../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-objdump
# CC=gcc

$CC main.c find_pa.c -o app_test_data
$OBJUMP -D -l app_test_data > app_test_data.s

# ff00ff04ff00ff03ff00ff02ff00ff01