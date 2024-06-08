#!/bin/bash
CC=$(realpath "../../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc
OBJUMP=$(realpath "../../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-objdump
# CC=gcc

$CC main.c find_pa.c -o app_test_inst
$OBJUMP -D -l app_test_inst > app_test_inst.s

# ff00ff04ff00ff03ff00ff02ff00ff01