{pkgs, ...}:
let
  script = pkgs.writeShellScript "script" ''
    while true; do
        # 30 minutes, 15 min off, 15 on
        ${pkgs.coreutils}/bin/sleep 1800
        export DISPLAY=:0
        ${pkgs.xorg.xset}/bin/xset dpms force on
    done'';
in
{
  services.xserver.monitorSection = ''
    Option "DPMS" "true"
'';

  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "15"
    Option "SuspendTime" "15"
    Option "OffTime" "15"
'';

  systemd.user.services.xorg-keep-screen-on = {
    enable = true;
    description = "Screen on without burn in";
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      ExecStart = script;
      Restart = "on-failure";
    };
  };
}
