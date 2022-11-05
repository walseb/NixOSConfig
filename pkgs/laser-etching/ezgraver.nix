with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "ezgraver";
  version = "master";

  # src = fetchgit {
  #   url = "https://github.com/camrein/EzGraver";
  #   deepClone = true;
  #   sha256 = "GLtqE81I6mKejImNkzSQwhjhxxfOd7LPra/QjrUaHew=";
  #   rev = "062696fcd2515ae49032fd2b6e623ade28862cc8";
  # };

  src = /home/admin/delete/EzGraver;

  dontWrapQtApps = true;

  buildInputs = [ stdenv libsForQt5.qtbase libsForQt5.qmake libsForQt5.qt5.qtserialport ];

  buildPhase = "
    qmake -config release EzGraver.pro
    make
  ";

  # mkdir -p $out/bin
  #   cp -r * $out/bin/

  installPhase = "
    make install
  ";
}
