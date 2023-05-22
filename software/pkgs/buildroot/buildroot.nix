{ stdenv
, fetchFromGitHub
, platform
, bash
}:

stdenv.mkDerivation rec {
    pname = "buildroot";
    version = "2022.11";

    src = fetchFromGitHub {
        owner = "buildroot";
        repo = "buildroot"; 
        rev = "${version}"; #tag
        sha256 = "sha256-XSBzShQ6bT+lFAT0eC36/SSP0lE5qQZ/QSe2fbCYvDk=";
    };

    setup = ../../setups/baremetal_linux/buildroot/aarch64.config;

    nativeBuildInputs = [ bash]; #build time dependencies
    
    buildPhase = ''
        export PLATFORM=${platform}
        make defconfig BR2_DEFCONFIG=$setup
        make linux-reconfigure all
    '';
    
    installPhase = ''
        mkdir -p $out/
        cp /output/images/Image $out/
    '';

}


