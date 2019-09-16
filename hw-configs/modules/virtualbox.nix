{ lib, config, pkgs, ... }:
with lib;
{
  boot.kernelParams = [ "nomodeset" ];

  # services.xserver.videoDrivers = [ati_unfree amdgpu amdgpu-pro nv nvidia nvidiaLegacy390 nvidiaLegacy340 nvidiaLegacy304 cirrus vesa vmware modesetting]
  # "vesa" "modesetting" "fbdev" "cirrus" "vmware" "virtualbox" "amdgpu" "cirrus" "fbdev"
  # "vmware" - vmware drivers
  # "virtualbox" - virtualbox drivers
  services.xserver.videoDrivers = mkOverride 40 [ "vmware" "virtualbox" "modesetting" ];

  powerManagement.enable = false;
  virtualisation.virtualbox.guest.enable = true;

  environment.systemPackages = with pkgs; [
    linuxPackages.virtualboxGuestAdditions
  ];
}
