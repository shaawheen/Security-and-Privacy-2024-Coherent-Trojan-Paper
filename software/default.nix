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
    # tools
    aarch64-none-elf = callPackage ./pkgs/toolchains/aarch64-none-elf-11-3.nix {};
    bootgen = callPackage ./pkgs/bootgen/bootgen.nix {toolchain = aarch64-none-elf;};
    # buildroot = callPackage ./pkgs/buildroot/buildroot.nix { inherit platform; };

    # firmwares
    baremetal = callPackage ./pkgs/guest/baremetal-guest.nix { toolchain = aarch64-none-elf; inherit platform; };
    linux = callPackage ./pkgs/guest/linux-guest.nix { toolchain = aarch64-none-elf; inherit platform; };
    bao = callPackage ./pkgs/bao/bao.nix { toolchain = aarch64-none-elf; vm1 = baremetal; vm2 = linux; inherit platform;};
    atf = callPackage ./pkgs/atf/atf.nix { toolchain = aarch64-none-elf; };
    xilinx_firmware = callPackage ./pkgs/firmware/firmware.nix { }; 

    gen_sd = callPackage ./pkgs/gen_sd/gen_sd.nix { inherit bao; inherit bootgen; inherit xilinx_firmware; inherit atf; };
    # scripts = callPackage ./pkgs/scripts/scripts.nix { inherit gen_sd; };
    inherit pkgs; # similar to `pkgs = pkgs;` This lets callers use the nixpkgs version defined in this file.
    
    sen_sd = writeTextFile { #result-8
      name = "send_sd.sh";
      executable = true;
      text = ''
        #!/bin/bash

        export BAO_SDCARD=/media/$USER/boot1
        
        if [ -d $BAO_SDCARD ]
            then  
                sudo rm -r $BAO_SDCARD/*
                sudo cp -r ${gen_sd}/boot_partition/* $BAO_SDCARD
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


