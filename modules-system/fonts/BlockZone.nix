with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "BlockZone";
  version = "1.004";

  src = fetchurl {
    url = "https://github.com/ansilove/BlockZone/releases/download/${version}/BlockZone-${version}.tar.gz";
    sha256 = "031l8aqjpncamhxgbzjfg2ha6yf5mrvdc1l80r3677r9bf5m2rq5";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $out/share/fonts/truetype
    '';

  meta = with stdenv.lib; {
    description = "BlockZone font";

    # See `License.txt' for details.
    license = licenses.ofl;
    homepage = https://github.com/ansilove/BlockZone;
  };
}
