#!/bin/bash

if [ -d ./backstabbing_devil ]
    then  
        echo $'\e[1;31m Deleting backstabbing_devil directory...\e[0m'
        rm -r backstabbing_devil
fi

# Open project in graphical mode
if [ "$1" == "graph" ]; then
    vivado -source design_1_graph.tcl
else
    echo $'\e[1;31m Building hardware components...\e[0m'
    vivado -mode tcl -source design_1.tcl
fi
