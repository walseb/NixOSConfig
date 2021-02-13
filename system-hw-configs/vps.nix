{ pkgs, ... }:

# Installed using nixos-in-place
{
  imports = [
    (import ../system-modules/boot/bios.nix { grub-dev = "/dev/vda"; })

    ../system-modules/VPS/nextcloud.nix
    ../system-modules/auto-upgrade-VPS.nix
  ];

  networking.usePredictableInterfaceNames = false;

  networking.interfaces.eth0.useDHCP = false;
  networking.interfaces.eth0.ipv4.addresses = [ { address = "46.246.93.80"; prefixLength = 24;} ];
  networking.defaultGateway = {
    address = "46.246.93.1";
    interface = "eth0";
  };

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
