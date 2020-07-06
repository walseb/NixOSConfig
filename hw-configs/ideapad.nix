{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [
    ./generic/laptop.nix
    ../modules/boot/bios-nvme.nix
    ../modules/hardware/printer.nix

    ../modules/hardware/acpi_call.nix

    ../modules/hardware/tlp/tlp-amd.nix
    ../modules/hardware/proprietary-firmware/amd.nix

    ../modules/hardware/graphics/vulkan.nix
    ../modules/hardware/graphics/amd-video.nix
  ];
}
