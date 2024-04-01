#!/bin/bash

CLEAR='\e[0m'
RED='\e[1;31m'
GREEN='\e[1;32m'

if [ -d ./out ]
    then 
        echo -e $''${RED}' Deleting out directory... '${CLEAR}'' 
        rm -r out
fi

rggen -c config.yml devil_reg_file.yml -o out --plugin rggen-verilog

IP=backstabber_1.0
cp ./out/devil_register_file.v ../../ip_repo/$IP/src
cp ./out/devil_register_file.vh ../../ip_repo/$IP/src
cp ./out/devil_register_file.vh ../../devil-in-fpga_DUT/src/sim
echo -e $''${GREEN}' New register file copied to '$IP' '${CLEAR}''

IP=test_register_file_1.0
cp ./out/devil_register_file.v ../../ip_repo/$IP/src
cp ./out/devil_register_file.vh ../../ip_repo/$IP/src
echo -e $''${GREEN}' New register file copied to '$IP' '${CLEAR}''

