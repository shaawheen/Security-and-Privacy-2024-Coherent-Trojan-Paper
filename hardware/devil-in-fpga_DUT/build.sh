#!/bin/bash

if [ -d ./devil-in-fpga_DUT ]
    then  
        echo $'\e[1;31m Deleting devil-in-fpga_DUT directory...\e[0m'
        rm -r devil-in-fpga_DUT
fi

rm *.jou *.log

# Open project in graphical mode
if [ "$1" == "graph" ]; then
    vivado -source build.tcl
else
    echo $'\e[1;31m Building hardware components...\e[0m'
    vivado -mode tcl -source build.tcl
fi
