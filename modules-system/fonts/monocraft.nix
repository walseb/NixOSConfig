with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "Monocraft";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "IdreesInc";
    repo = "Monocraft";
    rev = "d6538b9fa4366c81c4e8b33c86d4fc673f305d66";
    sha256 = "frg7LcMv6zWPWxkr6RIl01fC68THELbb45mJVqefXC0=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    mv *.otf $out/share/fonts/opentype
    '';
}
