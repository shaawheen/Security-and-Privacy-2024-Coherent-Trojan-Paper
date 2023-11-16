{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.11.tar.gz";
    sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";
  }) {}
}:

with pkgs;

let
  packages = rec {
    platform = "zcu102";
    #artifacts
    artifacts = callPackage ./pkgs/artifacts/artifacts.nix {};
    # tools
    aarch64-none-elf = callPackage ./pkgs/toolchains/aarch64-none-elf-11-3.nix {};
    bootgen = callPackage ./pkgs/bootgen/bootgen.nix {toolchain = aarch64-none-elf; };
    # buildroot = callPackage ./pkgs/buildroot/buildroot.nix { inherit artifacts; inherit platform; };

    # firmwares
    baremetal = callPackage ./pkgs/guest/baremetal-guest.nix { toolchain = aarch64-none-elf; inherit artifacts; inherit platform; };
    linux = callPackage ./pkgs/guest/linux-guest.nix { toolchain = aarch64-none-elf; inherit artifacts; inherit platform; };
    bao = callPackage ./pkgs/bao/bao.nix { toolchain = aarch64-none-elf; inherit artifacts; vm1 = baremetal; vm2 = linux; inherit platform;};
    # u-boot = callPackage ./pkgs/u-boot/u-boot.nix { toolchain = aarch64-none-elf; };
    atf = callPackage ./pkgs/atf/atf.nix { toolchain = aarch64-none-elf; inherit artifacts;};
    xilinx_firmware = callPackage ./pkgs/firmware/firmware.nix { inherit artifacts; inherit platform;}; 

    gen_sd = callPackage ./pkgs/gen_sd/gen_sd.nix { inherit artifacts; inherit bao; inherit bootgen; inherit xilinx_firmware; inherit atf; };
    # scripts = callPackage ./pkgs/scripts/scripts.nix { inherit gen_sd; };
    inherit pkgs; # similar to `pkgs = pkgs;` This lets callers use the nixpkgs version defined in this file.
    
    #result-9
    sen_sd = writeTextFile { 
      name = "send_sd.sh";
      executable = true;
      text = ''
        #!/bin/bash

        export BAO_SDCARD=/media/$USER/boot2
        
        if [ -d $BAO_SDCARD ]
            then  
                sudo rm -r $BAO_SDCARD/*
                sudo cp -r ${gen_sd}/boot_partition/* $BAO_SDCARD
                # Not needed for booting, just for testing porpuses to load baremetal without bao
                sudo cp ${baremetal}/baremetal.bin $BAO_SDCARD
                # Not needed for booting, just for testing porpuses to load linux without bao
                sudo cp ${linux}/linux.bin $BAO_SDCARD
                umount $BAO_SDCARD
                echo $'\e[1;32m SD Card flashed!\e[0m'
            else
                echo $'\e[1;31m SD Card not mounted!\e[0m'
        fi
      '';
    };
  };
in
  packages


