{ pkgs, ... }:
{
  imports = [
    ./cataclysm-dda-git-latest-override.nix
  ];

  home.packages = with pkgs; [
    cataclysm-dda-git-master
  ];
}
