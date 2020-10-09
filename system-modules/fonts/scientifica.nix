with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "scientifica";
  version = "2.1";

  src = fetchurl {
    url = "https://github.com/NerdyPepper/scientifica/releases/download/v${version}/scientifica-v${version}.tar";
    sha256 = "1djsgv6sgfw4kay6wbks3yqgrmbyyxq4i21aqg1hj0w5ww4wwn9i";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    # mv ttf/*.ttf $out/share/fonts/truetype
    mv ttf/scientifica.ttf $out/share/fonts/truetype
    mv ttf/scientificaBold.ttf $out/share/fonts/truetype
    '';

  meta = with stdenv.lib; {
    description = "Scientifica font";

    # See `License.txt' for details.
    license = licenses.ofl;
    homepage = https://github.com/NerdyPepper/scientifica;
  };
}
