{ pkg-s }:
with pkg-s;

stdenv.mkDerivation {
  pname = "Emacs Portal";
  version = "unstable-2022-12-16";

  src = fetchGit {
    name = "filechooser";
    url = "https://codeberg.org/rahguzar/filechooser";
    rev = "866304ab4244865108e12499f6e3be63e4981f92";
  };

  installPhase = ''
    mkdir -p $out/share/dbus-1/services/;
    cp org.gnu.Emacs.FileChooser.service $out/share/dbus-1/services/;
    mkdir -p $out/share/xdg-desktop-portal/portals/;
    cp emacs.portal $out/share/xdg-desktop-portal/portals/;
    '';
}
