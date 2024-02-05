{ pkg-s, ... }:

let
  compiledLayout = pkg-s.runCommand "keyboard-layout" {} ''
    ${pkg-s.xorg.xkbcomp}/bin/xkbcomp ${./path/to/layout.xkb} $out
  '';
in
{
  environment.systemPackages = with pkg-s; [
    xorg.setxkbmap
    xorg.xkbcomp
  ];

  services.xserver.displayManager.sessionCommands = "${pkg-s.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
}
