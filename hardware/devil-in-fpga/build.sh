#!/bin/bash

# Check if the script has at least 2 arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 [graph|build] [zcu102|zcu104]"
    exit 1
fi

if [ -d ./devil-in-fpga ]
    then  
        echo $'\e[1;31m Deleting devil-in-fpga directory...\e[0m'
        rm -r devil-in-fpga
fi

rm *.jou *.log

# Open project in graphical mode
case "$1" in
    "graph")
        case "$2" in
            "zcu102")
                echo $'\e[1;31m Building hardware components ZCU102 in graphical mode...\e[0m'
                vivado -source build_graph_zcu102.tcl
                ;;
            "zcu104")
                echo $'\e[1;31m Building hardware components ZCU104 in graphical mode...\e[0m'
                vivado -source build_graph_zcu104.tcl
                ;;
            *)
                echo $'\e[1;31m Board not Supported in graphical mode.\e[0m Use zcu102 or zcu104'
                ;;
        esac
        ;;
    "build")
        case "$2" in
            "zcu102")
                echo $'\e[1;31m Building hardware components ZCU102...\e[0m'
                vivado  -mode tcl  build_zcu102.tcl
                ;;
            "zcu104")
                echo $'\e[1;31m Building hardware components ZCU104...\e[0m'
                vivado  -mode tcl  build_zcu104.tcl
                ;;
            *)
                echo $'\e[1;31m Board not Supported in build mode.\e[0m Use zcu102 or zcu104'
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 [graph|build] [zcu102|zcu104]"
        exit 1
        ;;
esac
