{ pkgs, ... }:

{
  imports = [
    # ../system-modules/VPS/nextcloud.nix
    ../system-modules/boot/bios.nix
  ];
}
