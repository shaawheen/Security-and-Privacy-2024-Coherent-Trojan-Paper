
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_vip:1.*\
user.org:user:backstabber:1.*\
xilinx.com:ip:clk_wiz:6.*\
xilinx.com:ip:proc_sys_reset:5.*\
xilinx.com:ip:smartconnect:1.*\
user.org:user:test_register_file:1.*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set config_axi_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 config_axi_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {40} \
   CONFIG.ARUSER_WIDTH {1} \
   CONFIG.AWUSER_WIDTH {1} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {16} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $config_axi_0

  set m00_axi_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m00_axi_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {40} \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.HAS_REGION {0} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.PROTOCOL {AXI4} \
   ] $m00_axi_0

  set s00_axi_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s00_axi_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {40} \
   CONFIG.ARUSER_WIDTH {1} \
   CONFIG.AWUSER_WIDTH {1} \
   CONFIG.BUSER_WIDTH {1} \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {16} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {1} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {1} \
   ] $s00_axi_0


  # Create ports
  set acaddr_0 [ create_bd_port -dir I -from 43 -to 0 acaddr_0 ]
  set acsnoop_0 [ create_bd_port -dir I -from 3 -to 0 acsnoop_0 ]
  set acvalid_0 [ create_bd_port -dir I acvalid_0 ]
  set clk_100MHz [ create_bd_port -dir I -type clk -freq_hz 100000000 clk_100MHz ]
  set crready_0 [ create_bd_port -dir I crready_0 ]
  set crvalid_0 [ create_bd_port -dir O crvalid_0 ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset
  set w_acsnoop_type_0 [ create_bd_port -dir O -from 3 -to 0 w_acsnoop_type_0 ]
  set w_awaddr_0 [ create_bd_port -dir O -from 5 -to 0 w_awaddr_0 ]
  set w_base_addr_Data_0 [ create_bd_port -dir O -from 31 -to 0 w_base_addr_Data_0 ]
  set w_control_ACFLT_0 [ create_bd_port -dir O w_control_ACFLT_0 ]
  set w_control_ADDRFLT_0 [ create_bd_port -dir O w_control_ADDRFLT_0 ]
  set w_control_CONEN_0 [ create_bd_port -dir O w_control_CONEN_0 ]
  set w_control_CRRESP_0 [ create_bd_port -dir O -from 4 -to 0 w_control_CRRESP_0 ]
  set w_control_EN_0 [ create_bd_port -dir O w_control_EN_0 ]
  set w_control_FUNC_0 [ create_bd_port -dir O -from 3 -to 0 w_control_FUNC_0 ]
  set w_control_OSHEN_0 [ create_bd_port -dir O w_control_OSHEN_0 ]
  set w_control_TEST_0 [ create_bd_port -dir O -from 3 -to 0 w_control_TEST_0 ]
  set w_delay_data_0 [ create_bd_port -dir O -from 31 -to 0 w_delay_data_0 ]
  set w_mem_size_Data_0 [ create_bd_port -dir O -from 31 -to 0 w_mem_size_Data_0 ]
  set w_status_OSH_END_0 [ create_bd_port -dir O w_status_OSH_END_0 ]
  set w_wdata_0 [ create_bd_port -dir O -from 31 -to 0 w_wdata_0 ]
  set w_wvalid_0 [ create_bd_port -dir O w_wvalid_0 ]

  # Create instance: axi_vip_0, and set properties
  set axi_vip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.* axi_vip_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.INTERFACE_MODE {MASTER} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
 ] $axi_vip_0

  # Create instance: axi_vip_1, and set properties
  set axi_vip_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.* axi_vip_1 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {44} \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.INTERFACE_MODE {SLAVE} \
 ] $axi_vip_1

  # Create instance: backstabber_0, and set properties
  set backstabber_0 [ create_bd_cell -type ip -vlnv user.org:user:backstabber:1.* backstabber_0 ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.* clk_wiz_0 ]

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.* proc_sys_reset_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.* smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create instance: test_register_file_0, and set properties
  set test_register_file_0 [ create_bd_cell -type ip -vlnv user.org:user:test_register_file:1.* test_register_file_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_vip_0_M_AXI [get_bd_intf_pins axi_vip_0/M_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net backstabber_0_m00_axi [get_bd_intf_ports m00_axi_0] [get_bd_intf_pins backstabber_0/m00_axi]
  connect_bd_intf_net -intf_net config_axi_0_1 [get_bd_intf_ports config_axi_0] [get_bd_intf_pins backstabber_0/config_axi]
  connect_bd_intf_net -intf_net s00_axi_0_1 [get_bd_intf_ports s00_axi_0] [get_bd_intf_pins backstabber_0/s00_axi]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins backstabber_0/s01_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins smartconnect_0/M01_AXI] [get_bd_intf_pins test_register_file_0/S00_AXI]

  # Create port connections
  connect_bd_net -net acaddr_0_1 [get_bd_ports acaddr_0] [get_bd_pins backstabber_0/acaddr]
  connect_bd_net -net acsnoop_0_1 [get_bd_ports acsnoop_0] [get_bd_pins backstabber_0/acsnoop]
  connect_bd_net -net acvalid_0_1 [get_bd_ports acvalid_0] [get_bd_pins backstabber_0/acvalid]
  connect_bd_net -net axi_vip_1_s_axi_arready [get_bd_pins axi_vip_1/s_axi_arready] [get_bd_pins backstabber_0/arready]
  connect_bd_net -net axi_vip_1_s_axi_awready [get_bd_pins axi_vip_1/s_axi_awready] [get_bd_pins backstabber_0/awready]
  connect_bd_net -net axi_vip_1_s_axi_bresp [get_bd_pins axi_vip_1/s_axi_bresp] [get_bd_pins backstabber_0/bresp]
  connect_bd_net -net axi_vip_1_s_axi_bvalid [get_bd_pins axi_vip_1/s_axi_bvalid] [get_bd_pins backstabber_0/bvalid]
  connect_bd_net -net axi_vip_1_s_axi_rdata [get_bd_pins axi_vip_1/s_axi_rdata] [get_bd_pins backstabber_0/rdata]
  connect_bd_net -net axi_vip_1_s_axi_rlast [get_bd_pins axi_vip_1/s_axi_rlast] [get_bd_pins backstabber_0/rlast]
  connect_bd_net -net axi_vip_1_s_axi_rresp [get_bd_pins axi_vip_1/s_axi_rresp] [get_bd_pins backstabber_0/rresp]
  connect_bd_net -net axi_vip_1_s_axi_rvalid [get_bd_pins axi_vip_1/s_axi_rvalid] [get_bd_pins backstabber_0/rvalid]
  connect_bd_net -net axi_vip_1_s_axi_wready [get_bd_pins axi_vip_1/s_axi_wready] [get_bd_pins backstabber_0/wready]
  connect_bd_net -net backstabber_0_araddr [get_bd_pins axi_vip_1/s_axi_araddr] [get_bd_pins backstabber_0/araddr]
  connect_bd_net -net backstabber_0_arburst [get_bd_pins axi_vip_1/s_axi_arburst] [get_bd_pins backstabber_0/arburst]
  connect_bd_net -net backstabber_0_arcache [get_bd_pins axi_vip_1/s_axi_arcache] [get_bd_pins backstabber_0/arcache]
  connect_bd_net -net backstabber_0_arlen [get_bd_pins axi_vip_1/s_axi_arlen] [get_bd_pins backstabber_0/arlen]
  connect_bd_net -net backstabber_0_arlock [get_bd_pins axi_vip_1/s_axi_arlock] [get_bd_pins backstabber_0/arlock]
  connect_bd_net -net backstabber_0_arprot [get_bd_pins axi_vip_1/s_axi_arprot] [get_bd_pins backstabber_0/arprot]
  connect_bd_net -net backstabber_0_arqos [get_bd_pins axi_vip_1/s_axi_arqos] [get_bd_pins backstabber_0/arqos]
  connect_bd_net -net backstabber_0_arregion [get_bd_pins axi_vip_1/s_axi_arregion] [get_bd_pins backstabber_0/arregion]
  connect_bd_net -net backstabber_0_arsize [get_bd_pins axi_vip_1/s_axi_arsize] [get_bd_pins backstabber_0/arsize]
  connect_bd_net -net backstabber_0_arvalid [get_bd_pins axi_vip_1/s_axi_arvalid] [get_bd_pins backstabber_0/arvalid]
  connect_bd_net -net backstabber_0_awaddr [get_bd_pins axi_vip_1/s_axi_awaddr] [get_bd_pins backstabber_0/awaddr]
  connect_bd_net -net backstabber_0_awburst [get_bd_pins axi_vip_1/s_axi_awburst] [get_bd_pins backstabber_0/awburst]
  connect_bd_net -net backstabber_0_awcache [get_bd_pins axi_vip_1/s_axi_awcache] [get_bd_pins backstabber_0/awcache]
  connect_bd_net -net backstabber_0_awlen [get_bd_pins axi_vip_1/s_axi_awlen] [get_bd_pins backstabber_0/awlen]
  connect_bd_net -net backstabber_0_awlock [get_bd_pins axi_vip_1/s_axi_awlock] [get_bd_pins backstabber_0/awlock]
  connect_bd_net -net backstabber_0_awprot [get_bd_pins axi_vip_1/s_axi_awprot] [get_bd_pins backstabber_0/awprot]
  connect_bd_net -net backstabber_0_awqos [get_bd_pins axi_vip_1/s_axi_awqos] [get_bd_pins backstabber_0/awqos]
  connect_bd_net -net backstabber_0_awregion [get_bd_pins axi_vip_1/s_axi_awregion] [get_bd_pins backstabber_0/awregion]
  connect_bd_net -net backstabber_0_awsize [get_bd_pins axi_vip_1/s_axi_awsize] [get_bd_pins backstabber_0/awsize]
  connect_bd_net -net backstabber_0_awvalid [get_bd_pins axi_vip_1/s_axi_awvalid] [get_bd_pins backstabber_0/awvalid]
  connect_bd_net -net backstabber_0_bready [get_bd_pins axi_vip_1/s_axi_bready] [get_bd_pins backstabber_0/bready]
  connect_bd_net -net backstabber_0_crvalid [get_bd_ports crvalid_0] [get_bd_pins backstabber_0/crvalid]
  connect_bd_net -net backstabber_0_rready [get_bd_pins axi_vip_1/s_axi_rready] [get_bd_pins backstabber_0/rready]
  connect_bd_net -net backstabber_0_wdata [get_bd_pins axi_vip_1/s_axi_wdata] [get_bd_pins backstabber_0/wdata]
  connect_bd_net -net backstabber_0_wlast [get_bd_pins axi_vip_1/s_axi_wlast] [get_bd_pins backstabber_0/wlast]
  connect_bd_net -net backstabber_0_wstrb [get_bd_pins axi_vip_1/s_axi_wstrb] [get_bd_pins backstabber_0/wstrb]
  connect_bd_net -net backstabber_0_wvalid [get_bd_pins axi_vip_1/s_axi_wvalid] [get_bd_pins backstabber_0/wvalid]
  connect_bd_net -net clk_100MHz_1 [get_bd_ports clk_100MHz] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net clk_wiz_clk_out1 [get_bd_pins axi_vip_0/aclk] [get_bd_pins axi_vip_1/aclk] [get_bd_pins backstabber_0/ace_aclk] [get_bd_pins backstabber_0/config_axi_aclk] [get_bd_pins backstabber_0/m00_axi_aclk] [get_bd_pins backstabber_0/s00_axi_aclk] [get_bd_pins backstabber_0/s01_axi_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins test_register_file_0/s00_axi_aclk]
  connect_bd_net -net crready_0_1 [get_bd_ports crready_0] [get_bd_pins backstabber_0/crready]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clk_wiz_0/reset] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_100M_peripheral_aresetn [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axi_vip_1/aresetn] [get_bd_pins backstabber_0/ace_aresetn] [get_bd_pins backstabber_0/config_axi_aresetn] [get_bd_pins backstabber_0/m00_axi_aresetn] [get_bd_pins backstabber_0/s00_axi_aresetn] [get_bd_pins backstabber_0/s01_axi_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins test_register_file_0/s00_axi_aresetn]
  connect_bd_net -net test_register_file_0_w_acsnoop_type [get_bd_ports w_acsnoop_type_0] [get_bd_pins test_register_file_0/w_acsnoop_type]
  connect_bd_net -net test_register_file_0_w_awaddr [get_bd_ports w_awaddr_0] [get_bd_pins test_register_file_0/w_awaddr]
  connect_bd_net -net test_register_file_0_w_base_addr_Data [get_bd_ports w_base_addr_Data_0] [get_bd_pins test_register_file_0/w_base_addr_Data]
  connect_bd_net -net test_register_file_0_w_control_ACFLT [get_bd_ports w_control_ACFLT_0] [get_bd_pins test_register_file_0/w_control_ACFLT]
  connect_bd_net -net test_register_file_0_w_control_ADDRFLT [get_bd_ports w_control_ADDRFLT_0] [get_bd_pins test_register_file_0/w_control_ADDRFLT]
  connect_bd_net -net test_register_file_0_w_control_CONEN [get_bd_ports w_control_CONEN_0] [get_bd_pins test_register_file_0/w_control_CONEN]
  connect_bd_net -net test_register_file_0_w_control_CRRESP [get_bd_ports w_control_CRRESP_0] [get_bd_pins test_register_file_0/w_control_CRRESP]
  connect_bd_net -net test_register_file_0_w_control_EN [get_bd_ports w_control_EN_0] [get_bd_pins test_register_file_0/w_control_EN]
  connect_bd_net -net test_register_file_0_w_control_FUNC [get_bd_ports w_control_FUNC_0] [get_bd_pins test_register_file_0/w_control_FUNC]
  connect_bd_net -net test_register_file_0_w_control_OSHEN [get_bd_ports w_control_OSHEN_0] [get_bd_pins test_register_file_0/w_control_OSHEN]
  connect_bd_net -net test_register_file_0_w_control_TEST [get_bd_ports w_control_TEST_0] [get_bd_pins test_register_file_0/w_control_TEST]
  connect_bd_net -net test_register_file_0_w_delay_data [get_bd_ports w_delay_data_0] [get_bd_pins test_register_file_0/w_delay_data]
  connect_bd_net -net test_register_file_0_w_mem_size_Data [get_bd_ports w_mem_size_Data_0] [get_bd_pins test_register_file_0/w_mem_size_Data]
  connect_bd_net -net test_register_file_0_w_status_OSH_END [get_bd_ports w_status_OSH_END_0] [get_bd_pins test_register_file_0/w_status_OSH_END]
  connect_bd_net -net test_register_file_0_w_wdata [get_bd_ports w_wdata_0] [get_bd_pins test_register_file_0/w_wdata]
  connect_bd_net -net test_register_file_0_w_wvalid [get_bd_ports w_wvalid_0] [get_bd_pins test_register_file_0/w_wvalid]

  # Create address segments
  assign_bd_address -offset 0x80010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs backstabber_0/s01_axi/reg0] -force
  assign_bd_address -offset 0x80020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs test_register_file_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces backstabber_0/m00_axi] [get_bd_addr_segs m00_axi_0/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x010000000000 -target_address_space [get_bd_addr_spaces config_axi_0] [get_bd_addr_segs backstabber_0/config_axi/reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x010000000000 -target_address_space [get_bd_addr_spaces s00_axi_0] [get_bd_addr_segs backstabber_0/s00_axi/reg0] -force

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"0.47967",
   "Default View_TopLeft":"-494,-429",
   "ExpandedHierarchyInLayout":"",
   "PinnedBlocks":"/axi_vip_0|/clk_wiz_0|/proc_sys_reset_0|/backstabber_0|/smartconnect_0|/test_register_file_0|/axi_vip_1|",
   "PinnedPorts":"acaddr_0|acsnoop_0|acvalid_0|clk_100MHz|crready_0|crvalid_0|reset|w_control_FUNC_0|w_control_TEST_0|w_control_CRRESP_0|w_control_OSHEN_0|w_control_ADDRFLT_0|w_control_ACFLT_0|w_control_EN_0|w_control_CONEN_0|w_acsnoop_type_0|w_awaddr_0|w_base_addr_Data_0|w_delay_data_0|w_mem_size_Data_0|w_status_OSH_END_0|w_wdata_0|w_wvalid_0|config_axi_0|m00_axi_0|s00_axi_0|",
   "guistr":"# # String gsaved with Nlview 7.0r4  2019-12-20 bk=1.5203 VDI=41 GEI=36 GUI=JA:10.0 TLS
#  -string -flagsOSRD
preplace port config_axi_0 -pg 1 -lvl 0 -x -250 -y -210 -defaultsOSRD
preplace port m00_axi_0 -pg 1 -lvl 6 -x 2720 -y -410 -defaultsOSRD
preplace port s00_axi_0 -pg 1 -lvl 0 -x -250 -y -190 -defaultsOSRD
preplace port port-id_acvalid_0 -pg 1 -lvl 0 -x -250 -y -10 -defaultsOSRD
preplace port port-id_clk_100MHz -pg 1 -lvl 0 -x -250 -y -150 -defaultsOSRD
preplace port port-id_crready_0 -pg 1 -lvl 0 -x -250 -y 10 -defaultsOSRD
preplace port port-id_crvalid_0 -pg 1 -lvl 6 -x 2720 -y -350 -defaultsOSRD
preplace port port-id_reset -pg 1 -lvl 0 -x -250 -y -240 -defaultsOSRD
preplace port port-id_w_control_ACFLT_0 -pg 1 -lvl 6 -x 2720 -y 40 -defaultsOSRD
preplace port port-id_w_control_ADDRFLT_0 -pg 1 -lvl 6 -x 2720 -y 60 -defaultsOSRD
preplace port port-id_w_control_CONEN_0 -pg 1 -lvl 6 -x 2720 -y 100 -defaultsOSRD
preplace port port-id_w_control_EN_0 -pg 1 -lvl 6 -x 2720 -y -40 -defaultsOSRD
preplace port port-id_w_control_OSHEN_0 -pg 1 -lvl 6 -x 2720 -y 80 -defaultsOSRD
preplace port port-id_w_status_OSH_END_0 -pg 1 -lvl 6 -x 2720 -y 120 -defaultsOSRD
preplace port port-id_w_wvalid_0 -pg 1 -lvl 6 -x 2720 -y 220 -defaultsOSRD
preplace portBus acaddr_0 -pg 1 -lvl 0 -x -250 -y -70 -defaultsOSRD
preplace portBus acsnoop_0 -pg 1 -lvl 0 -x -250 -y -30 -defaultsOSRD
preplace portBus w_acsnoop_type_0 -pg 1 -lvl 6 -x 2720 -y 160 -defaultsOSRD
preplace portBus w_awaddr_0 -pg 1 -lvl 6 -x 2720 -y 240 -defaultsOSRD
preplace portBus w_base_addr_Data_0 -pg 1 -lvl 6 -x 2720 -y 180 -defaultsOSRD
preplace portBus w_control_CRRESP_0 -pg 1 -lvl 6 -x 2720 -y 20 -defaultsOSRD
preplace portBus w_control_FUNC_0 -pg 1 -lvl 6 -x 2720 -y 0 -defaultsOSRD
preplace portBus w_control_TEST_0 -pg 1 -lvl 6 -x 2720 -y -20 -defaultsOSRD
preplace portBus w_delay_data_0 -pg 1 -lvl 6 -x 2720 -y 140 -defaultsOSRD
preplace portBus w_mem_size_Data_0 -pg 1 -lvl 6 -x 2720 -y 200 -defaultsOSRD
preplace portBus w_wdata_0 -pg 1 -lvl 6 -x 2720 -y 260 -defaultsOSRD
preplace inst axi_vip_0 -pg 1 -lvl 2 -x 930 -y -170 -defaultsOSRD
preplace inst axi_vip_1 -pg 1 -lvl 5 -x 2430 -y 20 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -x 290 -y -90 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 1 -x 290 -y -320 -defaultsOSRD
preplace inst smartconnect_0 -pg 1 -lvl 3 -x 1190 -y 370 -defaultsOSRD
preplace inst test_register_file_0 -pg 1 -lvl 4 -x 1670 -y 1180 -defaultsOSRD
preplace inst backstabber_0 -pg 1 -lvl 4 -x 1670 -y 420 -defaultsOSRD
preplace netloc acaddr_0_1 1 0 4 -220J -160 500J -100 N -100 1390
preplace netloc acsnoop_0_1 1 0 4 -210J -20 NJ -20 N -20 1350
preplace netloc acvalid_0_1 1 0 4 NJ -10 NJ -10 N -10 1340
preplace netloc axi_vip_1_s_axi_arready 1 3 2 1430 -230 1980J
preplace netloc axi_vip_1_s_axi_awready 1 3 2 1440 -220 2150J
preplace netloc axi_vip_1_s_axi_bresp 1 3 2 1450 -210 1860J
preplace netloc axi_vip_1_s_axi_bvalid 1 3 2 1460 -200 2140J
preplace netloc axi_vip_1_s_axi_rdata 1 3 2 1470 -190 1970J
preplace netloc axi_vip_1_s_axi_rlast 1 3 2 1480 -180 2100J
preplace netloc axi_vip_1_s_axi_rresp 1 3 2 1490 -170 1900J
preplace netloc axi_vip_1_s_axi_rvalid 1 3 2 1410 -250 1940J
preplace netloc axi_vip_1_s_axi_wready 1 3 2 1420 -240 2130J
preplace netloc backstabber_0_araddr 1 4 1 1890 -330n
preplace netloc backstabber_0_arburst 1 4 1 1910 -310n
preplace netloc backstabber_0_arcache 1 4 1 1930 -290n
preplace netloc backstabber_0_arlen 1 4 1 1950 -270n
preplace netloc backstabber_0_arlock 1 4 1 1960 -250n
preplace netloc backstabber_0_arprot 1 4 1 1990 -230n
preplace netloc backstabber_0_arqos 1 4 1 1880 -210n
preplace netloc backstabber_0_arregion 1 4 1 1920 -170n
preplace netloc backstabber_0_arsize 1 4 1 2010 -150n
preplace netloc backstabber_0_arvalid 1 4 1 2020 -130n
preplace netloc backstabber_0_awaddr 1 4 1 2030 -110n
preplace netloc backstabber_0_awburst 1 4 1 1980 -90n
preplace netloc backstabber_0_awcache 1 4 1 2040 -70n
preplace netloc backstabber_0_awlen 1 4 1 2050 -50n
preplace netloc backstabber_0_awlock 1 4 1 2070 -30n
preplace netloc backstabber_0_awprot 1 4 1 2080 -10n
preplace netloc backstabber_0_awqos 1 4 1 2090 10n
preplace netloc backstabber_0_awregion 1 4 1 2110 50n
preplace netloc backstabber_0_awsize 1 4 1 2120 70n
preplace netloc backstabber_0_awvalid 1 4 1 2150 90n
preplace netloc backstabber_0_bready 1 4 1 2160 110n
preplace netloc backstabber_0_crvalid 1 4 2 1850 -420 2550
preplace netloc backstabber_0_rready 1 4 1 2170 210n
preplace netloc backstabber_0_wdata 1 4 1 2180 270n
preplace netloc backstabber_0_wlast 1 4 1 2190 290n
preplace netloc backstabber_0_wstrb 1 4 1 2200 330n
preplace netloc backstabber_0_wvalid 1 4 1 2210 350n
preplace netloc clk_100MHz_1 1 0 1 -230 -150n
preplace netloc clk_wiz_0_locked 1 0 2 -190 -170 470
preplace netloc clk_wiz_clk_out1 1 0 5 -200 -180 480 -90 1050 -90 1360 -160 2060
preplace netloc crready_0_1 1 0 4 NJ 10 NJ 10 N 10 1330
preplace netloc reset_1 1 0 1 -210 -340n
preplace netloc rst_clk_wiz_100M_peripheral_aresetn 1 1 4 520 -70 1030 -70 1370 -150 2000
preplace netloc test_register_file_0_w_acsnoop_type 1 4 2 2050J 1030 2600
preplace netloc test_register_file_0_w_awaddr 1 4 2 2170J 1040 2650
preplace netloc test_register_file_0_w_base_addr_Data 1 4 2 2080J 1050 2630
preplace netloc test_register_file_0_w_control_ACFLT 1 4 2 1860J 1060 2560
preplace netloc test_register_file_0_w_control_ADDRFLT 1 4 2 1930J 1070 2580
preplace netloc test_register_file_0_w_control_CONEN 1 4 2 2120J 1080 2620
preplace netloc test_register_file_0_w_control_CRRESP 1 4 2 NJ 1090 2570
preplace netloc test_register_file_0_w_control_EN 1 4 2 2030J 1100 2550
preplace netloc test_register_file_0_w_control_FUNC 1 4 2 1890J 1110 2590
preplace netloc test_register_file_0_w_control_OSHEN 1 4 2 2150J 1120 2640
preplace netloc test_register_file_0_w_control_TEST 1 4 2 1960J 1130 2610
preplace netloc test_register_file_0_w_delay_data 1 4 2 2200J 1170 2660
preplace netloc test_register_file_0_w_mem_size_Data 1 4 2 2210J 1180 2680
preplace netloc test_register_file_0_w_status_OSH_END 1 4 2 NJ 1190 2670
preplace netloc test_register_file_0_w_wdata 1 4 2 2210J 1280 2700
preplace netloc test_register_file_0_w_wvalid 1 4 2 NJ 1290 2690
preplace netloc axi_vip_0_M_AXI 1 2 1 1040 -170n
preplace netloc backstabber_0_m00_axi 1 4 2 1870 -410 N
preplace netloc config_axi_0_1 1 0 4 NJ -210 510J -80 N -80 1400
preplace netloc s00_axi_0_1 1 0 4 NJ -190 490J -60 N -60 1380
preplace netloc smartconnect_0_M00_AXI 1 3 1 1380 150n
preplace netloc smartconnect_0_M01_AXI 1 3 1 1330 380n
levelinfo -pg 1 -250 290 930 1190 1670 2430 2720
pagesize -pg 1 -db -bbox -sgen -410 -750 2970 2040
"
}

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


