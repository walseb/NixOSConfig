{ pkgs, ... }:

{
  imports = [
    ../system-modules/boot/uefi.nix
    ../system-modules/auto-upgrade-VPS.nix

    ../system-modules/hardware/proprietary-firmware/intel.nix
    ../system-modules/hardware/ntfs-support.nix
    ../system-modules/hardware/SSD.nix

    ../system-modules/xorg.nix
    ../system-modules/syncthing.nix
    ../system-modules/VPS/nextcloud.nix
    ../system-modules/network/wireguard-server.nix
    ../system-modules/network/sshd.nix
  ];
}
