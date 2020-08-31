{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # This doesn't have the elisp if you put it in home-manager
    mu
  ];
}
