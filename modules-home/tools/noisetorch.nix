# Maybe modify src at /nix/var/nix/profiles/per-user/root/channels/nixos/pkgs/games/cataclysm-dda/default.nix instead???
{ pkgs, pkg-s,
#  tiles ? true,
#  Cocoa, libicns,
#  debug ? false,
  ... }:
# let
#   inherit (pkg-s.callPackage ./common.nix { inherit tiles Cocoa debug; }) common utils;
# in
{
  nixpkgs.config = {
    packageOverrides = pkg-s: {
      noisetorch-git = (pkg-s.noisetorch.override { }).overrideAttrs (old: rec {
        version = "master";

        # fetchTarball "https://github.com/infinisil/all-hies/tarball/master"
        src = pkgs.fetchFromGitHub {
          owner = "lawl";
          repo = "NoiseTorch";
          rev = "02665f12db13e12ffcdaccf6c6b9ac3ed24cbfaa";
          sha256 = "06xlqjma8h7lcnqgc9226blps6m9dp487hk71lslfxj0jkay548k";
        };
      });
    };
  };
}
