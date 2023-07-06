#!/bin/bash

if [ -d ./devil-in-fpga ]
    then  
        echo $'\e[1;31m Deleting backstabbing_devil directory...\e[0m'
        rm -r devil-in-fpga
fi

rm . *.jou *.log

# Open project in graphical mode
if [ "$1" == "graph" ]; then
    vivado -source build_graph.tcl
else
    echo $'\e[1;31m Building hardware components...\e[0m'
    vivado -mode tcl -source build.tcl
fi
