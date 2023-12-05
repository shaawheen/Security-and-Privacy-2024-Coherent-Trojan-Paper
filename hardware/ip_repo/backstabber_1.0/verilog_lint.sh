#!/usr/bin/env nix-shell
#!nix-shell --pure -p verilator -i bash

DIR=`dirname $0`

if [ "$1" = "-unused" ]; then
    ## show unused signals
    verilator --lint-only -Wall -Wno-fatal -I${DIR}/hdl ${DIR}/hdl/active_devil.v
    verilator --lint-only -Wall -Wno-fatal -I${DIR}/hdl ${DIR}/hdl/passive_devil.v
    verilator --lint-only -Wall -Wno-fatal -I${DIR}/hdl ${DIR}/hdl/devil_in_fpga.v
else
    verilator --lint-only -Wall -Wno-style -Wno-fatal -I${DIR}/hdl ${DIR}/hdl/active_devil.v
    verilator --lint-only -Wall -Wno-style -Wno-fatal -I${DIR}/hdl ${DIR}/hdl/passive_devil.v
    verilator --lint-only -Wall -Wno-style -Wno-fatal -I${DIR}/hdl ${DIR}/hdl/devil_in_fpga.v
    verilator --lint-only -Wall -Wno-style -Wno-fatal -I${DIR}/hdl -I${DIR}/hdl/rggen-verilog-rtl -I${DIR}/src ${DIR}/hdl/backstabber_v1_0.v
fi
