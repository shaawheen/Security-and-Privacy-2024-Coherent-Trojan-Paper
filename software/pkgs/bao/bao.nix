{ stdenv
, fetchFromGitHub
, fetchurl
, toolchain
, platform
, vm1
, vm2
, ubootTools
, artifacts
}:

stdenv.mkDerivation rec {
    pname = "bao";
    version = "1.0.0";

    srcs = fetchFromGitHub {
        owner = "bao-project";
        repo = "bao-hypervisor";
        rev = "ca3091ef99c7d12f5b7a0e4a8e8aa8e358ae6f7c"; #main 
        sha256 = "sha256-2kC2zDPVtaiEdeK4LqGnsJl7bnJ8ptJUdFF2bHA73gY=";
    };

    patches = [
         "${artifacts}/bao.patch"
    ];

    config = "${artifacts}/setups/baremetal_linux/configs/${platform}.c";
    
    nativeBuildInputs = [ toolchain vm1 vm2 ubootTools]; #build time dependencies

    buildPhase = ''
        export ARCH=aarch64
        export CROSS_COMPILE=aarch64-none-elf-

        mkdir -p ./config
        cp -L ${config} ./config/bao_config.c

        mkdir -p ./images
        cp -L ${vm1}/baremetal.bin ./images
        cp -L ${vm2}/linux.bin ./images

        make PLATFORM=${platform}\
             CONFIG_REPO=./config\
             CONFIG=bao_config\
             CONFIG_BUILTIN=y\
             CPPFLAGS=-DBAO_WRKDIR_IMGS=./images

        ${ubootTools}/bin/mkimage -n bao_uboot -A arm64 -O linux -C none -T kernel -a 0x200000\
            -e 0x200000 -d ./bin/${platform}/bao_config/bao.bin ./bao.img
    '';
    
    installPhase = ''
        mkdir -p $out
        cp ./bao.img $out
    '';

}
