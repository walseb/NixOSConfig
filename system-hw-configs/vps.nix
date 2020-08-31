{ pkgs, ... }:

{
  imports = [
    # ../system-modules/VPS/nextcloud.nix
    ../system-modules/boot/bios.nix
    ./generic/linode.nix
  ];

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];

  services.sshd.enable = true;
}
