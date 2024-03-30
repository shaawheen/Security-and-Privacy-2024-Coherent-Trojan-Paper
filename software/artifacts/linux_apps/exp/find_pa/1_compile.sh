#!/bin/bash
CC=$(realpath "../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc
OBJUMP=$(realpath "../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-objdump

$CC main.c find_pa.c -o find_pa