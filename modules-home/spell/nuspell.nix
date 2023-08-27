{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nuspell

    hunspellDicts.en_US-large
    hunspellDicts.sv_SE
  ];
}
