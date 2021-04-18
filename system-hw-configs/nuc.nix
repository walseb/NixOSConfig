{ pkgs, ... }:

{
  imports = [
    ../system-modules/boot/uefi.nix
    ../system-modules/auto-upgrade-server.nix

    ../system-modules/hardware/proprietary-firmware/intel.nix
    ../system-modules/hardware/file-systems/ntfs-support.nix
    ../system-modules/hardware/SSD.nix
    ../system-modules/hardware/printer.nix

    ../system-modules/xorg.nix
    ../system-modules/syncthing.nix
    ../system-modules/network/wireguard-server.nix
    ../system-modules/network/sshd.nix
    ../system-modules/xorg-auto-login.nix

    (import ../nixos-private-config/remote-file-server/remote-file-server.nix { address = (import ../nixos-private-config/servers.nix).mainServer; })
  ];
}
