{ stdenv
, bootgen
, xilinx_firmware
, atf
, bao
, writeText
, writeTextFile
}:

stdenv.mkDerivation rec {
    pname = "gen_sd";
    version = "1.0";
    
    dontUnpack = true;
    dontBuild = true;

    bitstream = ../../artifacts;

    bif_file = writeText "bootgen.bif" ''
        the_ROM_image:
        {
            [bootloader, destination_cpu=a53-0] ${xilinx_firmware}/zynqmp_fsbl.elf
            [pmufw_image] ${xilinx_firmware}/pmufw.elf
            [destination_device=pl] ${bitstream}/backstabbing.bit 
            [destination_cpu=a53-0, exception_level=el-3, trustzone] ${atf}/bl31.elf
            [destination_cpu=a53-0, load=0x00100000] ${xilinx_firmware}/system.dtb
            [destination_cpu=a53-0, exception_level=el-2] ${xilinx_firmware}/u-boot.elf
        }
    '';

    installPhase = ''
        mkdir -p $out/boot_partition
        ${bootgen}/bootgen -arch zynqmp -image ${bif_file} -w -o $out/boot_partition/BOOT.BIN
        cp ${bao}/bao.img $out/boot_partition/
    '';

}


