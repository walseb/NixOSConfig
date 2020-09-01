{ pkgs, ... }:

{
  imports = [
    ../nixos-private-config/vps.nix

    ../system-modules/boot/bios.nix
    ./generic/linode.nix
    ../system-modules/VPS/nextcloud.nix
  ];

  services.sshd.enable = true;
}
