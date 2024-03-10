{ pkg-s, ... }:

{
  xdg.portal = {
    extraPortals = [
      # Not strictly needed for this package to work
      pkg-s.xdg-desktop-portal-gtk

      (import ./emacs/portal.nix { inherit pkg-s; })
    ];
    enable = true;
    xdgOpenUsePortal = true;
    config.common = {
      default = [ "gtk" ];

      # "org.freedesktop.impl.portal.FileChooser" = "gtk";

      "org.freedesktop.impl.portal.FileChooser" = "emacs";
    };
  };
}
