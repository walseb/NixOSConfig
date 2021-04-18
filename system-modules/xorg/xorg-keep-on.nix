{
  services.xserver.extraConfig = ''
    Option "DPMS" "true"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "15"
'';

  systemd.services.xorg-keep-on = {
    enable = true;
    description = "xorg keep on with anti burn in";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        while true; do
            # 30 minutes, 15 min off, 15 on
            sleep 1800
            xset dpms force on
        done
'';
      Restart = "on-failure";
    };
  };
}
