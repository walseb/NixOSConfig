{ config, pkgs, stdenv, lib,
  withNS ? stdenv.isDarwin,
  withX ? !stdenv.isDarwin,
  withGTK2 ? false,
  gtk2-x11 ? null,
  withGTK3 ? true,
  withXwidgets ? false,
  #withJson ? true,
  ... }:

let
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

      emacs = (pkgs.emacs.override { srcRepo = true; imagemagick = false; json = true; }).overrideAttrs (old: rec {
        name = "emacs-${version}${versionModifier}";
        version = "27.0.50";
        versionModifier = "-git";

#        configureFlags = [ "--with-modules" ] ++
#                         (lib.optional stdenv.isDarwin
#                           (lib.withFeature withNS "ns")) ++
#                         (if withNS
#                          then [ "--disable-ns-self-contained" ]
#                          else if withX
#                          then [ "--with-x-toolkit=${toolkit}" "--with-xft" ]
#                          else [ "--with-x=no" "--with-xpm=no" "--with-jpeg=no" "--with-png=no"
#                                 "--with-gif=no" "--with-tiff=no" ])
#                         ++ lib.optional withXwidgets "--with-xwidgets"
        # Compile with native json support
        #++ lib.optional withJson "--with-janson"
        #;

        src = pkgs.fetchFromGitHub {
          owner = "emacs-mirror";
          repo = "emacs";

          rev = "dea9970bc0deaf320e78c46a2e7456cbb6e7a0ea";
          sha256 = "1xnjxmd8bdi01wdqshl5w613xb5v2i9f1hm33hharggmnpwydr2q";
        };
        patches = [];
      });
    };
  };
}
