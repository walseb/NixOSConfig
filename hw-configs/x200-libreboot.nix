{
  imports = [
    ./modules/laptop.nix
    ./modules/boot/bios.nix
    ./modules/hardware/no-proprietary-drivers.nix
    ./modules/hardware/printer.nix
    # ./modules/hie.nix
  ];

  boot.loader.grub.copyKernels = true;
}
