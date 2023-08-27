with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "DejaVuBQNSansMono";
  version = "1.0";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/mlochbaum/BQN/master/docs/DejaVuBQNSansMono.ttf";
    sha256 = "sha256-+H5tbJzQbUkj711VeIgmOk8VvY/QLzfk8HOR/fVL3yA=";
  };
  dontUnpack = true;

  unpackPhase = "";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv DejaVuBQNSansMono.ttf $out/share/fonts/truetype
    '';
}
