{ config, pkgs, ... }:
{
  services.syncthing.enable = true;
  services.syncthing.dataDir = "/home/admin/.cache/syncthing/.config/";
  services.syncthing.configDir = "/home/admin/.cache/syncthing";

  services.syncthing.user = "admin";
  services.syncthing.group = "users";
}
