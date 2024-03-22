{   stdenv, 
    rsync
}:

stdenv.mkDerivation rec {
    pname = "artifacts";
    version = "1.0.0";

    src = ../../artifacts;

    nativeBuildInputs = [rsync];

    installPhase = ''
        mkdir -p $out
        rsync -av $src/ $out/ --exclude='linux_apps' --exclude='linux_src' --exclude='rt-bench'
    '';

    dontUnpack = true;
    dontBuild = true;
}


