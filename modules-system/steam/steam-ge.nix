# https://github.com/NixOS/nixpkgs/issues/73323#issuecomment-1079939987
with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "proton-ge-custom";
  version = "GE-Proton8-6";

  src = fetchurl {
    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
    sha256 = "0ePO6ZzsZpAb9iM++k4fYDwKzJpuZNgfPKwZePAUc0Y=";
  };

  buildCommand = ''
    mkdir -p $out
    tar -C $out --strip=1 -x -f $src
  '';
}
