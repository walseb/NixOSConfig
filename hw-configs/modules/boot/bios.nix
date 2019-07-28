{ config, ... }:
{
  imports = [
    ./grub.nix
  ];

  boot.loader.grub.device = "/dev/sda";
}
