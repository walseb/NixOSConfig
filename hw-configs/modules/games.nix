{ pkgs, ... }:
{
  imports = [
    ./games/cataclysm-dda/cataclysm-dda-git-latest.nix
  ];

  environment.systemPackages = with pkgs; [
    cataclysm-dda-git-master
  ];
}
