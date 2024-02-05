{ pkg-s, ... }:
{
  imports = [
    ./nmea-time-service.nix {
      nmea-time-pkg = ./nmea-time-build.nix;
      pkg-s = pkg-s;
    }
  ];
}
