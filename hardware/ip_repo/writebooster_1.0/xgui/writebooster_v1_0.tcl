# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_M00_AXI_BURST_LEN [ipgui::add_param $IPINST -name "C_M00_AXI_BURST_LEN" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths} ${C_M00_AXI_BURST_LEN}
  set C_M00_AXI_ID_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_ID_WIDTH" -parent ${Page_0}]
  set_property tooltip {Thread ID Width} ${C_M00_AXI_ID_WIDTH}
  set C_M00_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_ADDR_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of Address Bus} ${C_M00_AXI_ADDR_WIDTH}
  set C_M00_AXI_DATA_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Width of Data Bus} ${C_M00_AXI_DATA_WIDTH}
  set C_M00_AXI_AWUSER_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_AWUSER_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of User Write Address Bus} ${C_M00_AXI_AWUSER_WIDTH}
  set C_M00_AXI_ARUSER_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_ARUSER_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of User Read Address Bus} ${C_M00_AXI_ARUSER_WIDTH}
  set C_M00_AXI_WUSER_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_WUSER_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of User Write Data Bus} ${C_M00_AXI_WUSER_WIDTH}
  set C_M00_AXI_RUSER_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_RUSER_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of User Read Data Bus} ${C_M00_AXI_RUSER_WIDTH}
  set C_M00_AXI_BUSER_WIDTH [ipgui::add_param $IPINST -name "C_M00_AXI_BUSER_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of User Response Bus} ${C_M00_AXI_BUSER_WIDTH}

  ipgui::add_param $IPINST -name "QUEUE_DEPTH"

}

proc update_PARAM_VALUE.BUS_WIDTH { PARAM_VALUE.BUS_WIDTH } {
	# Procedure called to update BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BUS_WIDTH { PARAM_VALUE.BUS_WIDTH } {
	# Procedure called to validate BUS_WIDTH
	return true
}

proc update_PARAM_VALUE.CACHE_LINE_WIDTH_BITS { PARAM_VALUE.CACHE_LINE_WIDTH_BITS } {
	# Procedure called to update CACHE_LINE_WIDTH_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CACHE_LINE_WIDTH_BITS { PARAM_VALUE.CACHE_LINE_WIDTH_BITS } {
	# Procedure called to validate CACHE_LINE_WIDTH_BITS
	return true
}

proc update_PARAM_VALUE.C_ACE_ACSNOOP_WIDTH { PARAM_VALUE.C_ACE_ACSNOOP_WIDTH } {
	# Procedure called to update C_ACE_ACSNOOP_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ACE_ACSNOOP_WIDTH { PARAM_VALUE.C_ACE_ACSNOOP_WIDTH } {
	# Procedure called to validate C_ACE_ACSNOOP_WIDTH
	return true
}

proc update_PARAM_VALUE.C_ACE_ADDR_WIDTH { PARAM_VALUE.C_ACE_ADDR_WIDTH } {
	# Procedure called to update C_ACE_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ACE_ADDR_WIDTH { PARAM_VALUE.C_ACE_ADDR_WIDTH } {
	# Procedure called to validate C_ACE_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_ACE_DATA_WIDTH { PARAM_VALUE.C_ACE_DATA_WIDTH } {
	# Procedure called to update C_ACE_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ACE_DATA_WIDTH { PARAM_VALUE.C_ACE_DATA_WIDTH } {
	# Procedure called to validate C_ACE_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_ADDR_WIDTH { PARAM_VALUE.C_Config_AXI_ADDR_WIDTH } {
	# Procedure called to update C_Config_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_ADDR_WIDTH { PARAM_VALUE.C_Config_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_Config_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_ARUSER_WIDTH { PARAM_VALUE.C_Config_AXI_ARUSER_WIDTH } {
	# Procedure called to update C_Config_AXI_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_ARUSER_WIDTH { PARAM_VALUE.C_Config_AXI_ARUSER_WIDTH } {
	# Procedure called to validate C_Config_AXI_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_AWUSER_WIDTH { PARAM_VALUE.C_Config_AXI_AWUSER_WIDTH } {
	# Procedure called to update C_Config_AXI_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_AWUSER_WIDTH { PARAM_VALUE.C_Config_AXI_AWUSER_WIDTH } {
	# Procedure called to validate C_Config_AXI_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_BUSER_WIDTH { PARAM_VALUE.C_Config_AXI_BUSER_WIDTH } {
	# Procedure called to update C_Config_AXI_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_BUSER_WIDTH { PARAM_VALUE.C_Config_AXI_BUSER_WIDTH } {
	# Procedure called to validate C_Config_AXI_BUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_DATA_WIDTH { PARAM_VALUE.C_Config_AXI_DATA_WIDTH } {
	# Procedure called to update C_Config_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_DATA_WIDTH { PARAM_VALUE.C_Config_AXI_DATA_WIDTH } {
	# Procedure called to validate C_Config_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_ID_WIDTH { PARAM_VALUE.C_Config_AXI_ID_WIDTH } {
	# Procedure called to update C_Config_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_ID_WIDTH { PARAM_VALUE.C_Config_AXI_ID_WIDTH } {
	# Procedure called to validate C_Config_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_RUSER_WIDTH { PARAM_VALUE.C_Config_AXI_RUSER_WIDTH } {
	# Procedure called to update C_Config_AXI_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_RUSER_WIDTH { PARAM_VALUE.C_Config_AXI_RUSER_WIDTH } {
	# Procedure called to validate C_Config_AXI_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_Config_AXI_WUSER_WIDTH { PARAM_VALUE.C_Config_AXI_WUSER_WIDTH } {
	# Procedure called to update C_Config_AXI_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_Config_AXI_WUSER_WIDTH { PARAM_VALUE.C_Config_AXI_WUSER_WIDTH } {
	# Procedure called to validate C_Config_AXI_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ARUSER_WIDTH { PARAM_VALUE.C_S00_AXI_ARUSER_WIDTH } {
	# Procedure called to update C_S00_AXI_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ARUSER_WIDTH { PARAM_VALUE.C_S00_AXI_ARUSER_WIDTH } {
	# Procedure called to validate C_S00_AXI_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_AWUSER_WIDTH { PARAM_VALUE.C_S00_AXI_AWUSER_WIDTH } {
	# Procedure called to update C_S00_AXI_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_AWUSER_WIDTH { PARAM_VALUE.C_S00_AXI_AWUSER_WIDTH } {
	# Procedure called to validate C_S00_AXI_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BURST_LEN { PARAM_VALUE.C_S00_AXI_BURST_LEN } {
	# Procedure called to update C_S00_AXI_BURST_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BURST_LEN { PARAM_VALUE.C_S00_AXI_BURST_LEN } {
	# Procedure called to validate C_S00_AXI_BURST_LEN
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BUSER_WIDTH { PARAM_VALUE.C_S00_AXI_BUSER_WIDTH } {
	# Procedure called to update C_S00_AXI_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BUSER_WIDTH { PARAM_VALUE.C_S00_AXI_BUSER_WIDTH } {
	# Procedure called to validate C_S00_AXI_BUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ID_WIDTH { PARAM_VALUE.C_S00_AXI_ID_WIDTH } {
	# Procedure called to update C_S00_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ID_WIDTH { PARAM_VALUE.C_S00_AXI_ID_WIDTH } {
	# Procedure called to validate C_S00_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_RUSER_WIDTH { PARAM_VALUE.C_S00_AXI_RUSER_WIDTH } {
	# Procedure called to update C_S00_AXI_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_RUSER_WIDTH { PARAM_VALUE.C_S00_AXI_RUSER_WIDTH } {
	# Procedure called to validate C_S00_AXI_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_WUSER_WIDTH { PARAM_VALUE.C_S00_AXI_WUSER_WIDTH } {
	# Procedure called to update C_S00_AXI_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_WUSER_WIDTH { PARAM_VALUE.C_S00_AXI_WUSER_WIDTH } {
	# Procedure called to validate C_S00_AXI_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.QUEUE_DEPTH { PARAM_VALUE.QUEUE_DEPTH } {
	# Procedure called to update QUEUE_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.QUEUE_DEPTH { PARAM_VALUE.QUEUE_DEPTH } {
	# Procedure called to validate QUEUE_DEPTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_BURST_LEN { PARAM_VALUE.C_M00_AXI_BURST_LEN } {
	# Procedure called to update C_M00_AXI_BURST_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_BURST_LEN { PARAM_VALUE.C_M00_AXI_BURST_LEN } {
	# Procedure called to validate C_M00_AXI_BURST_LEN
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_ID_WIDTH { PARAM_VALUE.C_M00_AXI_ID_WIDTH } {
	# Procedure called to update C_M00_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_ID_WIDTH { PARAM_VALUE.C_M00_AXI_ID_WIDTH } {
	# Procedure called to validate C_M00_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_ADDR_WIDTH { PARAM_VALUE.C_M00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_M00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_ADDR_WIDTH { PARAM_VALUE.C_M00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_M00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_DATA_WIDTH { PARAM_VALUE.C_M00_AXI_DATA_WIDTH } {
	# Procedure called to update C_M00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_DATA_WIDTH { PARAM_VALUE.C_M00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_M00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_AWUSER_WIDTH { PARAM_VALUE.C_M00_AXI_AWUSER_WIDTH } {
	# Procedure called to update C_M00_AXI_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_AWUSER_WIDTH { PARAM_VALUE.C_M00_AXI_AWUSER_WIDTH } {
	# Procedure called to validate C_M00_AXI_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_ARUSER_WIDTH { PARAM_VALUE.C_M00_AXI_ARUSER_WIDTH } {
	# Procedure called to update C_M00_AXI_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_ARUSER_WIDTH { PARAM_VALUE.C_M00_AXI_ARUSER_WIDTH } {
	# Procedure called to validate C_M00_AXI_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_WUSER_WIDTH { PARAM_VALUE.C_M00_AXI_WUSER_WIDTH } {
	# Procedure called to update C_M00_AXI_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_WUSER_WIDTH { PARAM_VALUE.C_M00_AXI_WUSER_WIDTH } {
	# Procedure called to validate C_M00_AXI_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_RUSER_WIDTH { PARAM_VALUE.C_M00_AXI_RUSER_WIDTH } {
	# Procedure called to update C_M00_AXI_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_RUSER_WIDTH { PARAM_VALUE.C_M00_AXI_RUSER_WIDTH } {
	# Procedure called to validate C_M00_AXI_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXI_BUSER_WIDTH { PARAM_VALUE.C_M00_AXI_BUSER_WIDTH } {
	# Procedure called to update C_M00_AXI_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXI_BUSER_WIDTH { PARAM_VALUE.C_M00_AXI_BUSER_WIDTH } {
	# Procedure called to validate C_M00_AXI_BUSER_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_M00_AXI_BURST_LEN { MODELPARAM_VALUE.C_M00_AXI_BURST_LEN PARAM_VALUE.C_M00_AXI_BURST_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_BURST_LEN}] ${MODELPARAM_VALUE.C_M00_AXI_BURST_LEN}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_ID_WIDTH { MODELPARAM_VALUE.C_M00_AXI_ID_WIDTH PARAM_VALUE.C_M00_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_M00_AXI_ADDR_WIDTH PARAM_VALUE.C_M00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_M00_AXI_DATA_WIDTH PARAM_VALUE.C_M00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_AWUSER_WIDTH { MODELPARAM_VALUE.C_M00_AXI_AWUSER_WIDTH PARAM_VALUE.C_M00_AXI_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_ARUSER_WIDTH { MODELPARAM_VALUE.C_M00_AXI_ARUSER_WIDTH PARAM_VALUE.C_M00_AXI_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_WUSER_WIDTH { MODELPARAM_VALUE.C_M00_AXI_WUSER_WIDTH PARAM_VALUE.C_M00_AXI_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_RUSER_WIDTH { MODELPARAM_VALUE.C_M00_AXI_RUSER_WIDTH PARAM_VALUE.C_M00_AXI_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXI_BUSER_WIDTH { MODELPARAM_VALUE.C_M00_AXI_BUSER_WIDTH PARAM_VALUE.C_M00_AXI_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXI_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXI_BUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.QUEUE_DEPTH { MODELPARAM_VALUE.QUEUE_DEPTH PARAM_VALUE.QUEUE_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.QUEUE_DEPTH}] ${MODELPARAM_VALUE.QUEUE_DEPTH}
}

proc update_MODELPARAM_VALUE.C_ACE_ADDR_WIDTH { MODELPARAM_VALUE.C_ACE_ADDR_WIDTH PARAM_VALUE.C_ACE_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ACE_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_ACE_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_ACE_DATA_WIDTH { MODELPARAM_VALUE.C_ACE_DATA_WIDTH PARAM_VALUE.C_ACE_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ACE_DATA_WIDTH}] ${MODELPARAM_VALUE.C_ACE_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_ACE_ACSNOOP_WIDTH { MODELPARAM_VALUE.C_ACE_ACSNOOP_WIDTH PARAM_VALUE.C_ACE_ACSNOOP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ACE_ACSNOOP_WIDTH}] ${MODELPARAM_VALUE.C_ACE_ACSNOOP_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_ID_WIDTH { MODELPARAM_VALUE.C_Config_AXI_ID_WIDTH PARAM_VALUE.C_Config_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_Config_AXI_DATA_WIDTH PARAM_VALUE.C_Config_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_Config_AXI_ADDR_WIDTH PARAM_VALUE.C_Config_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_AWUSER_WIDTH { MODELPARAM_VALUE.C_Config_AXI_AWUSER_WIDTH PARAM_VALUE.C_Config_AXI_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_ARUSER_WIDTH { MODELPARAM_VALUE.C_Config_AXI_ARUSER_WIDTH PARAM_VALUE.C_Config_AXI_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_WUSER_WIDTH { MODELPARAM_VALUE.C_Config_AXI_WUSER_WIDTH PARAM_VALUE.C_Config_AXI_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_RUSER_WIDTH { MODELPARAM_VALUE.C_Config_AXI_RUSER_WIDTH PARAM_VALUE.C_Config_AXI_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_Config_AXI_BUSER_WIDTH { MODELPARAM_VALUE.C_Config_AXI_BUSER_WIDTH PARAM_VALUE.C_Config_AXI_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_Config_AXI_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_Config_AXI_BUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.BUS_WIDTH { MODELPARAM_VALUE.BUS_WIDTH PARAM_VALUE.BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BUS_WIDTH}] ${MODELPARAM_VALUE.BUS_WIDTH}
}

proc update_MODELPARAM_VALUE.CACHE_LINE_WIDTH_BITS { MODELPARAM_VALUE.CACHE_LINE_WIDTH_BITS PARAM_VALUE.CACHE_LINE_WIDTH_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CACHE_LINE_WIDTH_BITS}] ${MODELPARAM_VALUE.CACHE_LINE_WIDTH_BITS}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ID_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ID_WIDTH PARAM_VALUE.C_S00_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_BURST_LEN { MODELPARAM_VALUE.C_S00_AXI_BURST_LEN PARAM_VALUE.C_S00_AXI_BURST_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_BURST_LEN}] ${MODELPARAM_VALUE.C_S00_AXI_BURST_LEN}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_AWUSER_WIDTH { MODELPARAM_VALUE.C_S00_AXI_AWUSER_WIDTH PARAM_VALUE.C_S00_AXI_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ARUSER_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ARUSER_WIDTH PARAM_VALUE.C_S00_AXI_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_WUSER_WIDTH { MODELPARAM_VALUE.C_S00_AXI_WUSER_WIDTH PARAM_VALUE.C_S00_AXI_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_RUSER_WIDTH { MODELPARAM_VALUE.C_S00_AXI_RUSER_WIDTH PARAM_VALUE.C_S00_AXI_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_BUSER_WIDTH { MODELPARAM_VALUE.C_S00_AXI_BUSER_WIDTH PARAM_VALUE.C_S00_AXI_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_BUSER_WIDTH}
}

