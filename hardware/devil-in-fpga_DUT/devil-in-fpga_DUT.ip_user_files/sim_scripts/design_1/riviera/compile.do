vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/xil_defaultlib
vlib riviera/axi_vip_v1_1_12
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_13

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_vip_v1_1_12 riviera/axi_vip_v1_1_12
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 riviera/proc_sys_reset_v5_0_13

vlog -work xilinx_vip  -sv2k12 "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_vip_0_0/sim/design_1_axi_vip_0_0_pkg.sv" \

vlog -work axi_vip_v1_1_12  -sv2k12 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/1033/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_vip_0_0/sim/design_1_axi_vip_0_0.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_proc_sys_reset_0_0/sim/design_1_proc_sys_reset_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/design_1/ipshared/dfcd/hdl/devil_in_fpga.v" \
"../../../bd/design_1/ipshared/dfcd/hdl/fuzzing_ACE_v1_0_S01_AXI.v" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/design_1/ipshared/dfcd/hdl/ConfigurationPort.sv" \
"../../../bd/design_1/ipshared/dfcd/hdl/HPSPBRAM.sv" \
"../../../bd/design_1/ipshared/dfcd/hdl/queue.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../devil-in-fpga_DUT.gen/sources_1/bd/design_1/ipshared/4e49" "+incdir+/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/design_1/ipshared/dfcd/hdl/backstabber_v1_0.v" \
"../../../bd/design_1/ip/design_1_backstabber_0_0/sim/design_1_backstabber_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

