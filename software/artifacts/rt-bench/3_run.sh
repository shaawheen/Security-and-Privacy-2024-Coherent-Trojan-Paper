#!/bin/sh

if [ "$1" = "dis" ]; then
    cd vga
    ./disparity -p 1 -d 0.5 -t 2 -c 0 -f 99 -m 10M -l 3 -b .
elif [ "$1" = "isol" ]; then
    ./latency -p 1 -d 1 -t 1 -b "-m 4096 -s -i 1"
else
    echo "Usage: ./3_run.sh [dis|isol]"
fi