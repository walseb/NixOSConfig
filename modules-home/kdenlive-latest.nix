{ pkgs, ... }:
{
  home.packages = [
    pkgs.kdenlive
    pkgs.mlt
    pkgs.rubberband
  ];
}
