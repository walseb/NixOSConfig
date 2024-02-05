{ pkg-s }:
with pkg-s;

stdenv.mkDerivation rec {
  pname = "BlockZone";
  version = "1.004";

  src = fetchurl {
    url = "https://github.com/ansilove/BlockZone/releases/download/${version}/BlockZone-${version}.tar.gz";
    sha256 = "dCamA2lD+RoIz6j/vUZCJsQaqWRjInjHry6VDXOJKLE=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $out/share/fonts/truetype
    '';
}
