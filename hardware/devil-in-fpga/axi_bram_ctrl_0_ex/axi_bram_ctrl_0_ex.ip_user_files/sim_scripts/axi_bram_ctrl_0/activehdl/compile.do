vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/axi_bram_ctrl_v4_1_6
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap axi_bram_ctrl_v4_1_6 activehdl/axi_bram_ctrl_v4_1_6
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work axi_bram_ctrl_v4_1_6 -93 \
"../../../ipstatic/ipshared/3c31/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../axi_bram_ctrl_0_ex.gen/sources_1/ip/axi_bram_ctrl_0/sim/axi_bram_ctrl_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

