{ stdenv
, fetchFromGitHub
, dtc
, platform
, toolchain
}:

stdenv.mkDerivation rec {
    pname = "linux-guest";
    version = "6.1";

    src = ../../artifacts/linux/Image;
    config = ../../setups/baremetal_linux;

    # dontUnpack = true;

    # src = fetchFromGitHub {
    #     owner = "torvalds";
    #     repo = "linux";
    #     rev = "v${version}"; # tag
    #     sha256 = "";
    # };

    unpackPhase = ''
       cp ${src} ./Image
       mkdir -p ./setup
       cp -r ${config}/* ./setup
    '';

    nativeBuildInputs = [toolchain dtc]; #build time despendencies

    buildPhase = ''
        export CROSS_COMPILE=aarch64-none-elf-

        mkdir -p ./config
        dtc ${config}/devicetrees/${platform}/linux.dts > ./config/linux.dtb
        
        make -C ./setup/lloader\
            ARCH=aarch64\
            IMAGE=../../Image\
            DTB=../../config/linux.dtb\
            TARGET=../../linux.bin
    '';
    
    installPhase = ''
        mkdir -p $out
        cp ./linux.bin $out
    '';

}



