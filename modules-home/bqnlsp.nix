with import <nixpkgs> {};

stdenv.mkDerivation {
  pname = "fas3desktop";
  version = "3.0.45-1";

  src = builtins.fetchGit {
    name = "nixpkgs-emacs";
    url = "https://github.com/nixos/nixpkgs/";
    rev = "635a306fc8ede2e34cb3dd0d6d0a5d49362150ed";
  };

  propagatedBuildInputs = with pkgs; [
    dbus
    expat
    libgpgerror
    lzma
    mount
    pcre
    libselinux
    systemd
    libuuid
    xdg-utils
    zlib
  ];

  unpackCmd = "${dpkg}/bin/dpkg-deb -x $curSrc .";

  # dontUnpack = true;
  # unpackPhase = true;

  installPhase = ''
    ls -l
    mkdir -p $out
    cp -r ./fas3desktop/* $out/
    mkdir -p $out/share/applications/
    cp -r ./fas3desktop/lib/fas3desktop-FAS_3_Desktop_STP2.desktop $out/share/applications/
    cp $out/bin/* $out/bin/FAS3
  '';

  meta = with stdenv.lib; {
    description = "FAS 3 Desktop STP2";
  };
}
