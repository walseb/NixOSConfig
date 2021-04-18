{pkgs, ...}:
let
  script = pkgs.writeShellScript "script" ''
    while true; do
        # 30 minutes, 15 min off, 15 on
        ${pkgs.coreutils}/bin/sleep 1800
        ${pkgs.xorg.xset}/bin/xset dpms force on
    done'';
in
{
  services.xserver.monitorSection = ''
    Option "DPMS" "true"
'';

  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "15"
    Option "OffTime" "0"
'';

  systemd.services.xorg-keep-on = {
    enable = true;
    description = "xorg keep on with anti burn in";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = script;
      Restart = "on-failure";
    };
  };
}
