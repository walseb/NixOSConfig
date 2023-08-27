with import <nixpkgs> {};

# Fonts from Kreative Software.
# Includes FairFax, FairFaxHD
stdenv.mkDerivation rec {
  pname = "BQN386";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "dzaima";
    repo = "BQN386";
    rev = "81e18d1eb8cb6b66df9e311b3b63ec086d910d18";
    sha256 = "sha256-f0MbrxdkEiOqod41U07BvdDFDbFCqJuGyDIcx2Y24D0=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype;

    mv *.ttf $out/share/fonts/truetype;
    '';
}
