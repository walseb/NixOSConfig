{ pkgs, ... }:

# Installed using nixos-in-place
{
  imports = [
    ../system-modules/boot/bios.nix { grub-dev = "/dev/vda"; }

    ../system-modules/VPS/nextcloud.nix
    ../system-modules/auto-upgrade.nix
  ];

  networking.usePredictableInterfaceNames = false;
  networking.interfaces.eth0.useDHCP = true;

  networking.nameservers = [ "151.236.6.6 " "151.236.7.77" "1.1.1.1" ];

  boot.kernelParams = ["boot.shell_on_fail"];
  boot.loader.grub.storePath = "/nixos/nix/store";
  boot.initrd.supportedFilesystems = [ "ext4" ];
  boot.initrd.postDeviceCommands = ''
    mkdir -p /mnt-root/old-root ;
    mount -t ext4 /dev/vda2 /mnt-root/old-root ;
  '';
  fileSystems = {
    "/" = {
      device = "/old-root/nixos";
      fsType = "none";
      options = [ "bind" ];
    };
    "/old-root" = {
      device = "/dev/vda2";
      fsType = "ext4";
    };
  };
}
