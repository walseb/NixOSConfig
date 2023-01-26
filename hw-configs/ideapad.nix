{ pkgs, ... }:

{
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [
    ./generic/pc.nix
    # ./generic/midi.nix
    # (import ./generic/pc.nix { mouse-acceleration = false; pkgs = pkgs; })
    ./generic/laptop.nix
    # (import ../modules-system/boot/bios.nix { grub-dev = "/dev/nvme0n1"; })
    ../modules-system/boot/uefi.nix

    # ../modules-system/webcam-loopback.nix

    ../modules-system/hardware/printer-network.nix
    # ../modules-system/hardware/bluetooth.nix

    ../modules-system/hardware/acpi_call.nix
    ../modules-system/hardware/tlp/tlp-amd.nix

    # ../modules-system/hardware/proprietary-firmware/amd.nix # ../modules-system/hardware/proprietary-firmware/all-firmware.nix
    # ../modules-system/hardware/proprietary-firmware/redistributable-firmware.nix
    ../modules-system/hardware/proprietary-firmware/all-firmware.nix

    ../modules-system/hardware/graphics/vulkan.nix
    ../modules-system/hardware/graphics/amd-video.nix

    ../modules-system/syncthing.nix
    ../modules-system/redshift.nix
  ];

  services.xserver.libinput.touchpad.calibrationMatrix = "2, 0, 0, 0, 2, 0, 0, 0, 1";
  services.xserver.libinput.mouse.calibrationMatrix = "2, 0, 0, 0, 2, 0, 0, 0, 1";

  hardware.usbWwan.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
