{
  imports = [
    ./laptop.nix
    ./modules/boot/bios.nix
    ./modules/hardware/no-proprietary-drivers.nix
  ];

  boot.loader.grub.copyKernels = true;
}
