{ config, pkgs, ... }:

{
  # Required by spotify
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    spotify
  ];
}
