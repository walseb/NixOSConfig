{
  imports = [
    ./generic/pc.nix
    ./generic/laptop.nix
    ../system-modules/boot/bios.nix
    ../system-modules/hardware/no-proprietary-firmware.nix
    ../system-modules/hardware/printer.nix
    # ../system-modules/hie.nix
  ];

  boot.loader.grub.copyKernels = true;
}
