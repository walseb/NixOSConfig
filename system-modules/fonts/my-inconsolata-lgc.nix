with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "my-inconsolata-lgc";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "walseb";
    repo = "Inconsolata-LGC";
    rev = "bf4e4a20b5ff0826b3c92065b9d8f815dc484ebe";
    sha256 = "097a327mp76nhd9y6sykbm5gq9qyx1n8v2ak6pz4pb76c4bb4gpx";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mkdir -p $out/share/fonts/opentype
    mv *.ttf $out/share/fonts/truetype
    mv *.otf $out/share/fonts/opentype
    '';

  meta = with stdenv.lib; {
    description = "Inconsolata LGC patched with firafont ligatures";

    # See `License.txt' for details.
    license = licenses.ofl;
    homepage = https://github.com/walseb/Inconsolata-LGC;
  };
}
