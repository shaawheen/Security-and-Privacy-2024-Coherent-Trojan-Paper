{ stdenv
}:

stdenv.mkDerivation rec {
    pname = "artifacts";
    version = "1.0.0";

    src = ../../artifacts;

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
    '';

    dontUnpack = true;
    dontBuild = true;
}


