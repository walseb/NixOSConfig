{ lib, config, pkgs, ... }:
with lib;
{
  boot.kernelParams = [ "nomodeset" ];

  services.xserver.videoDrivers = mkOverride 40 [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting"];

  powerManagement.enable = false;
}
