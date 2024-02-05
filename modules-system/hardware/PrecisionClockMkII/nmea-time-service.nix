{ nmea-time-pkg, pkg-s, ... }:
{
  systemd.services.nmea-time-service = {
    serviceConfig.Type = "oneshot";
    script = "${nmea-time-pkg}/bin/nmea-time.py";
  };

  systemd.timers.nmea-time-timer = {
    enable = true;
    wantedBy = [ "timers.target" ];
    partOf = [ "nmea-time-service.service" ];
    timerConfig = {
      # Every 15 minutes
      OnCalendar = "*:0/15";
      Unit = "nmea-time-service.service";
    };
  };
}
