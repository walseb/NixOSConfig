with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "League Spartan";
  version = "master";

  propagatedBuildInputs = with pkgs; [
    unzip
  ];

  src = fetchurl {
    url = "https://befonts.com/wp-content/uploads/2022/03/league-spartan.zip";
    sha256 = "sha256-nUwUpJwBnZSfxeEhn2MnyVsjqZxQPytrlggjWIE4770=";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    cd static;
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $out/share/fonts/truetype
    '';
}
