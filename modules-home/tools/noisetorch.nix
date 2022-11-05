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
      noisetorch-git = (pkgs.noisetorch.override { }).overrideAttrs (old: rec {
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
