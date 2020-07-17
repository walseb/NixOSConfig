{ config, pkgs, ... }:
{
  services.syncthing.enable = true;
  # services.syncthing.dataDir = "/home/admin/Sync";

  services.syncthing.user = "admin";
  services.syncthing.group = "users";
}
