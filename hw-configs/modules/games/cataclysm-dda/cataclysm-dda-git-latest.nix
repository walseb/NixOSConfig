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

        src = pkgs.fetchFromGitHub {
          owner = "CleverRaven";
          repo = "Cataclysm-DDA";
          rev = "b6441480df77f063477f51a33fad9a21d3a96bdf";
          sha256 = "1bd0fci7x6fkjpz4432sixrkgks262n0gsmzzg3nqk8rgclbsfn6";
        };
        patches = [ ];

        #        nativeBuildInputs = common.nativeBuildInputs
        #                            ++  [ pkgs.autoconf ];
      });
    };
  };
}
