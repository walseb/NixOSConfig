{pkgs, extraConfig, ...}:
let
  script = pkgs.writeShellScript "script" ''
    ${extraConfig}
    while true; do
        # 30 minutes, 15 min off, 15 on
        ${pkgs.coreutils}/bin/sleep 1800
        ${pkgs.xorg.xset}/bin/xset dpms force on
    done'';
in
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
      ExecStart = script;
      Restart = "on-failure";
    };
  };
}
