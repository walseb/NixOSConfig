{ pkgs, ... }:

{
  imports = [
    ../system-modules/boot/bios.nix

    ./generic/linode.nix
    ../system-modules/VPS/nextcloud.nix
    ../system-modules/auto-upgrade-VPS.nix
  ];
}
