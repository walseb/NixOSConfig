with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "ITC Avant Garde Gothic Medium";
  version = "master";

  propagatedBuildInputs = with pkgs; [
    unzip
  ];

  src = fetchurl {
    url = "https://media.fontsgeek.com/download/zip/i/t/itc-avant-garde-gothic-std-medium_Z4pxm.zip";
    sha256 = "sha256-M51smxfVtEvZAcqMPGbN4qBaqHIdpBhynSQLGeYDdjw=";
  };


  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    cd "ITC Avant Garde Gothic Std Medium";
    mkdir -p $out/share/fonts/opentype
    mv *.otf $out/share/fonts/opentype
    '';
}
