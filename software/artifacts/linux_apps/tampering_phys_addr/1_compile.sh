#!/bin/bash
CC=$(realpath "../../")/build_toolchain/bin/aarch64-buildroot-linux-gnu-gcc

$CC main.c -o tampering_phys_addr