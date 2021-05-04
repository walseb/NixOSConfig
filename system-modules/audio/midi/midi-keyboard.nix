{ pkgs, ... }:
{
  systemd.services.a2jmidid = {
    enable = true;
    description = "a2jmidid";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "admin";
      Group = "users";
      ExecStart = "${pkgs.a2jmidid}/bin/a2jmidid";
      Restart = "on-failure";
    };
  };
}
