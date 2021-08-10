{ nmea-time-pkg, pkgs, ... }:
{
  systemd.services.nmea-time-service = {
    enable = true;
    description = "Nmea-time service";
    serviceConfig = {
      ExecStart = "${nmea-time-pkg}/bin/nmea-time.py";
      TimeoutStartSec= "infinity";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
  };
}
