#!/bin/bash
CC=$(realpath "../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc
OBJUMP=$(realpath "../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-objdump

$CC main.c find_pa.c -o victim_match
$OBJUMP -D -l victim_match > victim_match_dump.s