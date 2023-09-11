#!/bin/bash

if [ -d ./devil-in-fpga ]
    then  
        echo $'\e[1;31m Deleting devil-in-fpga directory...\e[0m'
        rm -r devil-in-fpga
fi

rm *.jou *.log

# Open project in graphical mode
if [ "$1" == "graph" ]; then
    if [ "$2" == "zcu102" ]; then
        vivado -source build_graph_zcu102.tcl
    fi 
    if [ "$2" == "zcu104" ]; then
        vivado -source build_graph_zcu104.tcl
    fi 
    if [ "$2" != "zcu102" ]  && [ "$2" != "zcu104" ]
    then
        echo $'\e[1;31m Board not Supported.\e[0m Use zcu102 or zcu104'
    fi 
else
    if [ "$2" == "zcu102" ]; then
        echo $'\e[1;31m Building hardware components ZCU102...\e[0m'
        vivado -source build_zcu102.tcl
    fi 
    if [ "$2" == "zcu104" ]; then
        echo $'\e[1;31m Board not Supported.\e[0m Use zcu102 or zcu104'
        vivado -source build_zcu104.tcl
    fi 
    if [ "$2" != "zcu102" ]  && [ "$2" != "zcu104" ]
    then
        echo $'\e[1;31m Board not Supported.\e[0m Use zcu102 or zcu104'
    fi 
fi
