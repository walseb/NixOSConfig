{ config, pkg-s, ... }:
{
  home.packages = with pkg-s; [
    nuspell

    hunspellDicts.en_US-large
    hunspellDicts.sv_SE
  ];
}
