{
  imports = [
    ./generic/home.nix
    ./generic/laptop.nix
    ../modules/boot/bios.nix
    ../modules/hardware/no-proprietary-firmware.nix
    ../modules/hardware/printer.nix
    # ../modules/hie.nix
  ];

  boot.loader.grub.copyKernels = true;
}
