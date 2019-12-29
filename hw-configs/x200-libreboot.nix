{
  imports = [
    ./modules/boot/bios.nix
    ./modules/carpalx-layout.nix
    ./modules/hardware/no-proprietary-drivers.nix
    ./modules/network/wifi.nix
  ];

  boot.loader.grub.copyKernels = true;
}
