-makelib xcelium_lib/xilinx_vip -sv \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xpm -sv \
  "/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/tools/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ipshared/b425/hdl/AXI_PerfectTranslator_v1_0_M00_AXI.v" \
  "../../../bd/design_1/ipshared/b425/hdl/AXI_PerfectTranslator_v1_0_S00_AXI.v" \
  "../../../bd/design_1/ipshared/b425/hdl/AXI_PerfectTranslator_v1_0.v" \
  "../../../bd/design_1/ip/design_1_AXI_PerfectTranslator_0_0/sim/design_1_AXI_PerfectTranslator_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ipshared/5a55/hdl/ConfigurationPort.sv" \
  "../../../bd/design_1/ipshared/5a55/hdl/HPSPBRAM.sv" \
  "../../../bd/design_1/ipshared/5a55/hdl/queue.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ipshared/5a55/hdl/backstabber_v1_0.v" \
  "../../../bd/design_1/ip/design_1_backstabber_0_0/sim/design_1_backstabber_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ipshared/4765/hdl/config_port.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ipshared/4765/hdl/byte_writer_v1_0.v" \
  "../../../bd/design_1/ip/design_1_byte_writer_0_0/sim/design_1_byte_writer_0_0.v" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_13 \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_rst_ps8_0_99M_0/sim/design_1_rst_ps8_0_99M_0.vhd" \
-endlib
-makelib xcelium_lib/xlconstant_v1_1_7 \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_0/sim/bd_48ac_one_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_1/sim/bd_48ac_psr_aclk_0.vhd" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/c012/hdl/sc_switchboard_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_2/sim/bd_48ac_arsw_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_3/sim/bd_48ac_rsw_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_4/sim/bd_48ac_awsw_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_5/sim/bd_48ac_wsw_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_6/sim/bd_48ac_bsw_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/ea34/hdl/sc_mmu_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_7/sim/bd_48ac_s00mmu_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/4fd2/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_8/sim/bd_48ac_s00tr_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/8047/hdl/sc_si_converter_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_9/sim/bd_48ac_s00sic_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/f38e/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_10/sim/bd_48ac_s00a2s_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/66be/hdl/sc_node_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_11/sim/bd_48ac_sarn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_12/sim/bd_48ac_srn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_13/sim/bd_48ac_sawn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_14/sim/bd_48ac_swn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_15/sim/bd_48ac_sbn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_16/sim/bd_48ac_s01mmu_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_17/sim/bd_48ac_s01tr_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_18/sim/bd_48ac_s01sic_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_19/sim/bd_48ac_s01a2s_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_20/sim/bd_48ac_sarn_1.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_21/sim/bd_48ac_srn_1.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_22/sim/bd_48ac_sawn_1.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_23/sim/bd_48ac_swn_1.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_24/sim/bd_48ac_sbn_1.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/9cc5/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_25/sim/bd_48ac_m00s2a_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_26/sim/bd_48ac_m00arn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_27/sim/bd_48ac_m00rn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_28/sim/bd_48ac_m00awn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_29/sim/bd_48ac_m00wn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_30/sim/bd_48ac_m00bn_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/6bba/hdl/sc_exit_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_31/sim/bd_48ac_m00e_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_32/sim/bd_48ac_m01s2a_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_33/sim/bd_48ac_m01arn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_34/sim/bd_48ac_m01rn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_35/sim/bd_48ac_m01awn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_36/sim/bd_48ac_m01wn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_37/sim/bd_48ac_m01bn_0.sv" \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_38/sim/bd_48ac_m01e_0.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/sim/bd_48ac.v" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_register_slice_v2_1_26 \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/0a3f/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_12 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/1033/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_smartconnect_0_0/sim/design_1_smartconnect_0_0.v" \
  "../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_0/sim/bd_f60c_ila_lib_0.v" \
  "../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/sim/bd_f60c.v" \
  "../../../bd/design_1/ip/design_1_system_ila_0_0/sim/design_1_system_ila_0_0.v" \
  "../../../bd/design_1/ip/design_1_vio_0_0/sim/design_1_vio_0_0.v" \
-endlib
-makelib xcelium_lib/zynq_ultra_ps_e_vip_v1_0_12 -sv \
  "../../../../project_1.gen/sources_1/bd/design_1/ipshared/8cdf/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \
  "../../../bd/design_1/sim/design_1.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

