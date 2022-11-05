# Maybe modify src at /nix/var/nix/profiles/per-user/root/channels/nixos/pkgs/games/cataclysm-dda/default.nix instead???
{ pkgs,
#  tiles ? true,
#  Cocoa, libicns,
#  debug ? false,
  ... }:
# let
#   inherit (pkgs.callPackage ./common.nix { inherit tiles Cocoa debug; }) common utils;
# in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      cataclysm-dda-git-master = (pkgs.cataclysm-dda-git.override { }).overrideAttrs (old: rec {
        version = "master";

        # fetchTarball "https://github.com/infinisil/all-hies/tarball/master"
        src = pkgs.fetchFromGitHub {
          owner = "CleverRaven";
          repo = "Cataclysm-DDA";
          rev = "789d3b2f22325461b6080765bb2743579f73622b";
          sha256 = "08bxwh2b8ih1pxdsqlks0byy9cfx8fln047a7q40n8ax45qyjybm";
        };
        patches = [ ];

        #        nativeBuildInputs = common.nativeBuildInputs
        #                            ++  [ pkgs.autoconf ];
      });
    };
  };
}
