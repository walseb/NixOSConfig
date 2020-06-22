{ config, ... }:
{
  imports = [
    ./grub.nix
  ];

  boot.loader.grub.device = "/dev/nvme0n1";
}
