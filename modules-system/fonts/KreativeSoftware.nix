{ pkg-s }:
with pkg-s;

# Fonts from Kreative Software.
# Includes FairFax, FairFaxHD
stdenv.mkDerivation rec {
  pname = "KreativeSoftwareFonts";
  version = "1.0";

  src = pkg-s.fetchFromGitHub {
    owner = "kreativekorp";
    repo = "open-relay";
    rev = "f4e03b75219d4d22104d4915d7141ff749f9720f";
    sha256 = "sha256-dCamA2lD+RoIz6j/vUZCJsQaqWRjInjHry6VDXOJKLE=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype;

    mv AlcoSans/*.ttf $out/share/fonts/truetype;
    mv Constructium/*.ttf $out/share/fonts/truetype;
    mv Fairfax/*.ttf $out/share/fonts/truetype;
    mv FairfaxHD/*.ttf $out/share/fonts/truetype;
    mv KreativeSquare/*.ttf $out/share/fonts/truetype;
    '';
}
