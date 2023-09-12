#*****************************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# build.tcl: Tcl script for re-creating project 'project_1'
#
#*****************************************************************************************

# Set the project name
set _xil_proj_name_ "devil-in-fpga"

# Set the reference directory to where the script is
set origin_dir [file dirname [info script]]

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

variable script_file
set script_file "build.tcl"

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/"]"

# Create project
create_project ${_xil_proj_name_} $origin_dir/${_xil_proj_name_} -part xczu7ev-ffvc1156-2-e


# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "board_part_repo_paths" -value "[file normalize "$origin_dir/../../../../../../.Xilinx/Vivado/2021.2/xhub/board_store/xilinx_board_store"]" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_resource_estimation" -value "0" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "part" -value "xczu7ev-ffvc1156-2-e" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "xpm_libraries" -value "XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
if { $obj != {} } {
   set_property "ip_repo_paths" "[file normalize "$origin_dir/../ip_repo"]" $obj

   # Rebuild user ip_repo's index before adding any source files
   update_ip_catalog -rebuild
}

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property -name "target_part" -value "xczu7ev-ffvc1156-2-e" -objects $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

puts "INFO: Project created:${_xil_proj_name_}"

# Create block design
source $origin_dir/src/bd/design_1.tcl

 # Generate the wrapper
 set design_name [get_bd_designs]
 make_wrapper -files [get_files $design_name.bd] -top -import

save_bd_design

## Generate bitstream

launch_runs impl_1 -to_step write_bitstream -jobs 6

get_property PROGRESS [get_runs synth_1]
get_property PROGRESS [get_runs impl_1]

