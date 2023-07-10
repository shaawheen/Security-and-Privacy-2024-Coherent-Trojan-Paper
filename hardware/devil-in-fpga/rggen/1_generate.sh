#!/bin/bash

if [ -d ./out ]
    then  
        echo $'\e[1;31m Deleting out directory...\e[0m'
        rm -r out
fi

rggen -c config.yml devil_reg_file.yml -o out --plugin rggen-verilog
