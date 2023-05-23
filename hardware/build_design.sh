#!/bin/bash

if [ -d ./backstabbing_devil ]
    then  
        echo $'\e[1;31m Deleting backstabbing_devil directory...\e[0m'
        rm -r backstabbing_devil
fi

echo $'\e[1;31m Building hardware components...\e[0m'
# vivado -source design_1.tcl
vivado -mode tcl -source design_1.tcl
