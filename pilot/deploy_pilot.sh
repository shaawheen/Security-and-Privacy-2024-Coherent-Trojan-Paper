#!/bin/bash

#BOARD="zcu102"
#BOARD_REV="3.3"

#BOARD="kv260_som"
#BOARD_REV="1.2"

#BD_NAME="base_devil"
#IP_REPO_FOLDER_PATH="/home/shahin/project44/devil-in-the-fpga/hardware/ip_repo/"

#BD_NAME="base_caesar"
#BD_NAME="base_backstabbing"
#BD_NAME="base_plim"
#IP_REPO_FOLDER_PATH="/home/shahin/project44/cache_stabbing/ip_wip"

VIVADO_MASTER_PATH="/home/shahin/startup/xilinx_vivado_pilot/vivado_master.sh"
PROJECT_FOLDER_PATH="/home/shahin/project44/devil-in-the-fpga/dev/"
BD_PATH="/home/shahin/project44/devil-in-the-fpga/${BD_NAME}.tcl"

BOOT_MASTER_PATH="/home/shahin/startup/xilinx_boot_pilot/build_master.sh"
BITSTREAM_PATH="${PROJECT_FOLDER_PATH}/${BD_NAME}_vivado_2023.2_zcu102_v3.3.bit"
SD_CARD_BOOT_PARTITION_PATH="/media/shahin/BOOT/"
SD_CARD_ROOT_PARTITION_PATH="/media/shahin/rootfs/"

bash              ${VIVADO_MASTER_PATH} \
     -board       ${BOARD} \
     -rev         ${BOARD_REV} \
     -vivado      2023.2 \
     -bd          ${BD_PATH} \
     -ip          ${IP_REPO_FOLDER_PATH} \
     -target      ${PROJECT_FOLDER_PATH} \
     -name        ${BD_NAME} \
     -extract \
     -verbose \
     -gui
#     -bit 

echo "running buildmaster:" 
bash ${BOOT_MASTER_PATH} \
     -board        ${BOARD} \
     -bit          ${BITSTREAM_PATH} \
     -target       ${PROJECT_FOLDER_PATH} \
     -sd-boot      ${SD_CARD_BOOT_PARTITION_PATH}
#     -no-ace
#     -sd-root      ${SD_CARD_ROOT_PARTITION_PATH} \
#     -atf-ver         [optional] [version] \  #Set firmware version (default: 2022.1)
#     -xlnx-ver        [optional] [version] \  #Set embedded linux version (default: 2022.1)
#     -bootgen-ver     [optional] [version] \  #Set bootgen version (default: 2022.1)
