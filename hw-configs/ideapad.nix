{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelParams = ["acpi=force" "reboot=acpi"];
  # boot.kernelParams = ["acpi=strict"];

  imports = [
    ../modules/laptop.nix
    ../modules/boot/bios-nvme.nix
    ../modules/hardware/proprietary-drivers.nix
    ../modules/hardware/printer.nix

    # ../modules/build-emacs.nix
  ];
}
