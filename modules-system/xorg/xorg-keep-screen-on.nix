{pkg-s, ...}:
let
  script = pkg-s.writeShellScript "script" ''
    export DISPLAY=:0
    while true; do
        # 15 min on
        ${pkg-s.coreutils}/bin/sleep 900
        ${pkg-s.xorg.xset}/bin/xset dpms force off
        # 15 min off
        ${pkg-s.coreutils}/bin/sleep 900
        ${pkg-s.xorg.xset}/bin/xset dpms force on
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

  systemd.services.xorg-keep-screen-on = {
    enable = true;
    description = "Screen on without burn in";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "admin";
      Group = "users";
      ExecStart = script;
      Restart = "on-failure";
    };
  };
}
