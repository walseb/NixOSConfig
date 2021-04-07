{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [
    ./generic/pc.nix
    # (import ./generic/pc.nix { mouse-acceleration = false; pkgs = pkgs; })
    ./generic/laptop.nix
    # (import ../system-modules/boot/bios.nix { grub-dev = "/dev/nvme0n1"; })
    ../system-modules/boot/uefi.nix

    # ../../system-modules/webcam.nix

    ../system-modules/hardware/printer.nix

    # ../system-modules/hardware/acpi_call.nix
    # ../system-modules/hardware/tlp/tlp-amd.nix

    ../system-modules/hardware/proprietary-firmware/amd.nix # ../system-modules/hardware/proprietary-firmware/all-firmware.nix

    # ../system-modules/hardware/graphics/vulkan.nix
    # ../system-modules/hardware/graphics/amd-video.nix

    ../system-modules/syncthing.nix
  ];
}
