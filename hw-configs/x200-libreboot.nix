{
  imports = [
    ./generic/pc.nix
    ./generic/laptop.nix
    ../modules-system/boot/bios.nix
    ../modules-system/hardware/no-proprietary-firmware.nix
    ../modules-system/hardware/printer.nix
    # ../modules-system/hie.nix
  ];

  boot.loader.grub.copyKernels = true;
}
