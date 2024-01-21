{ pkgs, ... }:
{
  imports = [
    ./nmea-time-service.nix {
      nmea-time-pkg = ./nmea-time-build.nix;
      pkgs = pkgs;
    }
  ];
}
