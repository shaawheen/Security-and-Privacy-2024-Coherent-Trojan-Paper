{ stdenv
, artifacts
}:

stdenv.mkDerivation rec {
    pname = "xilinx_firmware";
    version = "2022.1";

    # Download From -> https://www.xilinx.com/member/forms/download/xef.html?filename=2022.1-zcu102-release.tar.xz
    src = "${artifacts}/2022.1-zcu102-release.tar.gz";

    installPhase = ''
        mkdir -p $out
        cp -r * $out
    '';
    
    dontBuild = true;
}


