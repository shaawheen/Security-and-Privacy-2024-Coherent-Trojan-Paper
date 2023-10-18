{ stdenv
, fetchFromGitHub
, toolchain
, platform
, artifacts
}:

stdenv.mkDerivation rec {
    pname = "baremetal-guest";
    version = "1.0.0";

    # src = fetchFromGitHub {
    #     owner = "bao-project";
    #     repo = "bao-baremetal-guest";
    #     rev = "4010db4ba5f71bae72d4ceaf4efa3219812c6b12"; # branch demo
    #     sha256 = "sha256-aiKraDtjv+n/cXtdYdNDKlbzOiBxYTDrMT8bdG9B9vU=";
    # };

    src = "${artifacts}/baremetal";

    nativeBuildInputs = [ toolchain]; #build time dependencies

    unpackPhase = ''
       mkdir -p ./src
       cp -r ${src}/* ./src
    '';

    buildPhase = ''
        cd ./src
        export ARCH=aarch64
        export CROSS_COMPILE=aarch64-none-elf-
        make PLATFORM=${platform} MEM_BASE=0x20000000 MEM_SIZE=0x30000000
    '';
    
    installPhase = ''
        mkdir -p $out
        cp ./build/${platform}/baremetal.asm $out
        cp ./build/${platform}/baremetal.lst $out
        cp ./build/${platform}/baremetal.bin $out
    '';

}


