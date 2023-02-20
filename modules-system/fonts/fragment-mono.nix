with import <nixpkgs> {};

# Helvetica mono
stdenv.mkDerivation rec {
  pname = "Fragment-mono";
  version = "unstable-2022-12-16";

  src = pkgs.fetchFromGitHub {
    owner = "weiweihuanghuang";
    repo = "fragment-mono";
    rev = "82bba49f9abaf0705c1b3ab1392d31ae82bc3070";
    sha256 = "07xzl41l7l8abi6gcspqdngkkdvsgqyhlf7sfj7f5ziz28l64wnn";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    mv fonts/otf/*.otf $out/share/fonts/opentype
    '';
}
