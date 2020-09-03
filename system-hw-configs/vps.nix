{ pkgs, ... }:

{
  imports = [
    ../nixos-private-config/vps.nix

    ../system-modules/boot/bios.nix

    ./generic/linode.nix
    ../system-modules/VPS/nextcloud.nix
    ../system-modules/auto-upgrade.nix
    ../system-modules/network/sshd.nix
  ];
}
