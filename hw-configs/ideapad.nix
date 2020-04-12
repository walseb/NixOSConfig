{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [
    ./modules/boot/bios-nvme.nix
    ./modules/laptop.nix
    ./modules/hardware/proprietary-drivers.nix
    ./modules/hardware/printer.nix
    ./modules/build-emacs.nix
  ];
}
