{ pkg-s }:
with pkg-s;

stdenv.mkDerivation rec {
  pname = "ITC Avant Garde Gothic Medium";
  version = "master";

  # propagatedBuildInputs = with pkg-s; [
  #   unzip
  # ];

  # src = fetchurl {
  #   url = "https://media.fontsgeek.com/download/zip/i/t/itc-avant-garde-gothic-std-medium_Z4pxm.zip";
  #   sha256 = "sha256-M51smxfVtEvZAcqMPGbN4qBaqHIdpBhynSQLGeYDdjw=";
  # };


  dontUnpack = true;

  src = ./ITC_Avant_Garde_Gothic_Std_Medium;

  installPhase = ''
    cd $src;
    mkdir -p $out/share/fonts/opentype
    cp *.otf $out/share/fonts/opentype
    '';
}
