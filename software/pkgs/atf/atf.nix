{ stdenv
, fetchFromGitHub
, toolchain
, openssl
}:

stdenv.mkDerivation rec {
    pname = "atf-xilinx";
    version = "2022.1";
    platform = "qemu-aarch64-virt";

    src = fetchFromGitHub {
        owner = "Xilinx";
        repo = "arm-trusted-firmware";
        rev = "xilinx-v${version}"; 
        sha256 = "sha256-In98OT60ELrbybj1dS6kLrdPSQFO7UbwNkb2zbxM0jo=";
    };

    patches = [
         ../../atf.patch
    ];

    nativeBuildInputs = [ toolchain openssl]; #build time dependencies

    buildPhase = ''
        export CROSS_COMPILE=aarch64-none-elf-
        make -f Makefile DEBUG=0 PLAT=zynqmp bl31
    '';
    
    installPhase = ''
        mkdir -p $out
        cp ./build/zynqmp/release/bl31/bl31.elf $out
    '';

}


