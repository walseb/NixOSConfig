{ config, pkgs, lib, ... }:

let
  isLinux = true;

  withGTK2 = false;
  withGTK3 = true;

  withXwidgets = false;

  withNS = false;
  withX = true;
  isDarwin = false;

  withJson = true;
  withHarfbuzz = true;
  withoutGTKScrollbars = true;

  gtk2-x11 = null;
  gsettings-desktop-schemas = null;

  toolkit =
    if withGTK2 then "gtk2"
    else if withGTK3 then "gtk3"
    else "lucid";
in
{
  nixpkgs.config = {
    # Install emacs git
    # /nix/var/nix/profiles/per-user/root/channels/nixos/pkgs/applications/editors/emacs/default.nix
    packageOverrides = pkgs: {

      emacs = (pkgs.emacs.override { srcRepo = true; }).overrideAttrs (old: rec {
        name = "emacs-${version}${versionModifier}";
        version = "27.0.50";
        versionModifier = "-git";

        buildInputs =
          [ pkgs.ncurses pkgs.libxml2 pkgs.gnutls pkgs.alsaLib pkgs.acl pkgs.gpm pkgs.gettext ]
          ++ lib.optionals isLinux [ pkgs.dbus pkgs.libselinux pkgs.systemd ]
          ++ lib.optionals withX
            [ pkgs.xlibsWrapper pkgs.xorg.libXaw pkgs.Xaw3d pkgs.xorg.libXpm pkgs.libpng pkgs.libjpeg pkgs.libungif pkgs.libtiff pkgs.librsvg pkgs.xorg.libXft ]
          ++ lib.optionals (isLinux && withX) [ pkgs.m17n_lib pkgs.libotf ]
          ++ lib.optional (withX && withGTK2) gtk2-x11
          ++ lib.optionals (withX && withGTK3) [ pkgs.gtk3-x11 pkgs.gsettings-desktop-schemas ]
          ++ lib.optional (isDarwin && withX) pkgs.cairo
          ++ lib.optionals (withX && withXwidgets) [ pkgs.webkitgtk ]

          ++ lib.optionals withJson [ pkgs.jansson ]

          ++ lib.optionals withNS [
            pkgs.AppKit pkgs.GSS pkgs.ImageIO
            # Needed for CFNotificationCenterAddObserver symbols.
            pkgs.cf-private
          ];

          configureFlags =
            [ "--with-modules" ] ++
            (lib.optional withNS
            (lib.withFeature withNS "ns")) ++
            (if withNS
            then [ "--disable-ns-self-contained" ]
            else if withX
            then [ "--with-x-toolkit=${toolkit}" "--with-xft" ]
            else [ "--with-x=no" "--with-xpm=no" "--with-jpeg=no" "--with-png=no"

            "--with-gif=no" "--with-tiff=no" ])
            ++ lib.optional withXwidgets "--with-xwidgets"
            ++ lib.optional withJson "--with-json"
            ++ lib.optional withHarfbuzz "--with-harfbuzz"
            ++ lib.optional withoutGTKScrollbars "--without-toolkit-scroll-bars";

            src = pkgs.fetchFromGitHub {
              owner = "emacs-mirror";
              repo = "emacs";

              # Remember to change BOTH rev and sha256, otherwise it doesn't clone correctly
              rev = "fd27685c1e68e742abf1698573dac53743f15e48";
              sha256 = "1i5abp00xx913qpv9lbx64ypcr6hc2wbnsfjf9q2891zf7vmhwzh";
            };
            patches = [];
      });
    };
  };
}
