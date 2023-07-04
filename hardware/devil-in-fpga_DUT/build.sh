#!/bin/bash

# Open project in graphical mode
if [ "$1" == "graph" ]; then
    vivado -source build.tcl
else
    echo $'\e[1;31m Building hardware components...\e[0m'
    vivado -mode tcl -source build.tcl
fi
