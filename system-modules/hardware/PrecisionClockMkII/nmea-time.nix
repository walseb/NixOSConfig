{ pkgs, ... }:
{
  imports = [
    (import ./nmea-time-service.nix {
      nmea-time-pkg = (import ./nmea-time-build.nix);
      pkgs = pkgs;
    })
  ];
}
