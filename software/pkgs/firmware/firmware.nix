{ stdenv
, artifacts
, platform
}:

stdenv.mkDerivation rec {
    pname = "xilinx_firmware";
    version = "2022.1";

    # Download From -> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/2347204609/2022.1+Release
    src = "${artifacts}/2022.1-${platform}-release.tar.gz";
    installPhase = ''
        mkdir -p $out
        cp -r * $out
    '';
    
    dontBuild = true;
}


