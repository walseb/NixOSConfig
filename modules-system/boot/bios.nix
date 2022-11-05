{ grub-dev ? "/dev/sda" }:
{
  imports = [
    ./grub.nix
  ];

  boot.loader.grub.device = grub-dev;
}
