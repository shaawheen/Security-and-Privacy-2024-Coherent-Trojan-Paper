{ stdenv
, fetchFromGitHub
, openssl
, toolchain
}:

stdenv.mkDerivation rec {
    pname = "bootgen";
    version = "v2022.1";

    src = fetchFromGitHub {
        owner = "Xilinx";
        repo = "bootgen";
        rev = "xilinx_v2022.1"; # Tag
        sha256 = "sha256-mh5tfdaIIQAnu0WzF7V3+Wkf9qAh6UOopVcuIQ1p5ow=";
    };

    nativeBuildInputs = [ toolchain]; #build time dependencies
    buildInputs = [ openssl]; #run time dependencies
    enableParallelBuilding = true;

    buildPhase = ''
        make
    '';
    
    installPhase = ''
        mkdir -p $out
        cp ./bootgen $out
    '';

}


