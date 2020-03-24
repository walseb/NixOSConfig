{
  imports = [
    ./laptop.nix
    ./modules/boot/bios.nix
    ./modules/hardware/no-proprietary-drivers.nix
    ./modules/hardware/print.nix
    # ./modules/hie.nix
  ];

  boot.loader.grub.copyKernels = true;
}
