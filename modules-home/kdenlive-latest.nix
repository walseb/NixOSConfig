{ pkgs, ... }:
let
  new-pkgs =
    # import (fetchTarball "https://github.com/rycee/home-manager/archive/release-22.11.tar.gz")
    import (builtins.fetchGit {
      name = "nixpkgs-emacs";
      url = "https://github.com/nixos/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      # WARNING: update-nix-fetchgit updates this to the latest master
      rev = "37b97ae3dd714de9a17923d004a2c5b5543dfa6d";
      # ref = "refs/heads/nixos-22.11";
      # rev = "e285dd0ca97c264003867c7329f0d1f4f028739c";
    }){};
in
{
  home.packages = [
    new-pkgs.kdenlive
    new-pkgs.mlt
    new-pkgs.rubberband
  ];
}
