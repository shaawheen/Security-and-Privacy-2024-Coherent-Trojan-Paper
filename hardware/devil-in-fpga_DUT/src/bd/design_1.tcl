
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

  # Create instance: backstabber_0, and set properties
  set backstabber_0 [ create_bd_cell -type ip -vlnv user.org:user:backstabber:1.* backstabber_0 ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.* clk_wiz_0 ]

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.* proc_sys_reset_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_vip_0_M_AXI [get_bd_intf_pins axi_vip_0/M_AXI] [get_bd_intf_pins backstabber_0/s01_axi]
  connect_bd_intf_net -intf_net backstabber_0_m00_axi [get_bd_intf_ports m00_axi_0] [get_bd_intf_pins backstabber_0/m00_axi]
  connect_bd_intf_net -intf_net config_axi_0_1 [get_bd_intf_ports config_axi_0] [get_bd_intf_pins backstabber_0/config_axi]
  connect_bd_intf_net -intf_net s00_axi_0_1 [get_bd_intf_ports s00_axi_0] [get_bd_intf_pins backstabber_0/s00_axi]

  # Create port connections
  connect_bd_net -net acaddr_0_1 [get_bd_ports acaddr_0] [get_bd_pins backstabber_0/acaddr]
  connect_bd_net -net acsnoop_0_1 [get_bd_ports acsnoop_0] [get_bd_pins backstabber_0/acsnoop]
  connect_bd_net -net acvalid_0_1 [get_bd_ports acvalid_0] [get_bd_pins backstabber_0/acvalid]
  connect_bd_net -net backstabber_0_crvalid [get_bd_ports crvalid_0] [get_bd_pins backstabber_0/crvalid]
  connect_bd_net -net clk_100MHz_1 [get_bd_ports clk_100MHz] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net clk_wiz_clk_out1 [get_bd_pins axi_vip_0/aclk] [get_bd_pins backstabber_0/ace_aclk] [get_bd_pins backstabber_0/config_axi_aclk] [get_bd_pins backstabber_0/m00_axi_aclk] [get_bd_pins backstabber_0/s00_axi_aclk] [get_bd_pins backstabber_0/s01_axi_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net crready_0_1 [get_bd_ports crready_0] [get_bd_pins backstabber_0/crready]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clk_wiz_0/reset] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_100M_peripheral_aresetn [get_bd_pins axi_vip_0/aresetn] [get_bd_pins backstabber_0/ace_aresetn] [get_bd_pins backstabber_0/config_axi_aresetn] [get_bd_pins backstabber_0/m00_axi_aresetn] [get_bd_pins backstabber_0/s00_axi_aresetn] [get_bd_pins backstabber_0/s01_axi_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]

  # Create address segments
  assign_bd_address -offset 0x80010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs backstabber_0/s01_axi/reg0] -force

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"1.89465",
   "Default View_TopLeft":"545,-471",
   "ExpandedHierarchyInLayout":"",
   "PinnedBlocks":"/clk_wiz_0|/proc_sys_reset_0|/axi_vip_0|/backstabber_0|",
   "PinnedPorts":"reset|clk_100MHz|",
   "guistr":"# # String gsaved with Nlview 7.0r4  2019-12-20 bk=1.5203 VDI=41 GEI=36 GUI=JA:10.0 TLS
#  -string -flagsOSRD
preplace port s00_axi_0 -pg 1 -lvl 0 -x -10 -y -190 -defaultsOSRD
preplace port config_axi_0 -pg 1 -lvl 0 -x -10 -y -210 -defaultsOSRD
preplace port m00_axi_0 -pg 1 -lvl 5 -x 1300 -y -410 -defaultsOSRD
preplace port port-id_clk_100MHz -pg 1 -lvl 0 -x -10 -y -150 -defaultsOSRD
preplace port port-id_reset -pg 1 -lvl 0 -x -10 -y -240 -defaultsOSRD
preplace port port-id_acvalid_0 -pg 1 -lvl 0 -x -10 -y -10 -defaultsOSRD
preplace port port-id_crvalid_0 -pg 1 -lvl 5 -x 1300 -y -350 -defaultsOSRD
preplace port port-id_crready_0 -pg 1 -lvl 0 -x -10 -y 10 -defaultsOSRD
preplace portBus acsnoop_0 -pg 1 -lvl 0 -x -10 -y -30 -defaultsOSRD
preplace portBus acaddr_0 -pg 1 -lvl 0 -x -10 -y -70 -defaultsOSRD
preplace inst axi_vip_0 -pg 1 -lvl 3 -x 800 -y -170 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -x 190 -y -170 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 2 -x 500 -y -170 -defaultsOSRD
preplace inst backstabber_0 -pg 1 -lvl 4 -x 1100 -y 100 -defaultsOSRD
preplace netloc acaddr_0_1 1 0 4 20J -60 NJ -60 NJ -60 920J
preplace netloc acsnoop_0_1 1 0 4 NJ -30 NJ -30 NJ -30 NJ
preplace netloc acvalid_0_1 1 0 4 NJ -10 NJ -10 NJ -10 NJ
preplace netloc backstabber_0_crvalid 1 4 1 N -350
preplace netloc clk_100MHz_1 1 0 1 20 -160n
preplace netloc clk_wiz_0_locked 1 1 1 290 -160n
preplace netloc clk_wiz_clk_out1 1 1 3 310 -50 680 -70 900
preplace netloc crready_0_1 1 0 4 NJ 10 NJ 10 NJ 10 NJ
preplace netloc reset_1 1 0 2 20 -250 320
preplace netloc rst_clk_wiz_100M_peripheral_aresetn 1 2 2 690 -100 910
preplace netloc axi_vip_0_M_AXI 1 3 1 N -170
preplace netloc backstabber_0_m00_axi 1 4 1 N -410
preplace netloc config_axi_0_1 1 0 4 10J -270 NJ -270 NJ -270 920J
preplace netloc s00_axi_0_1 1 0 4 30J -240 300J -70 670J -240 900J
levelinfo -pg 1 -10 190 500 800 1100 1300
pagesize -pg 1 -db -bbox -sgen -160 -750 1420 1140
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


