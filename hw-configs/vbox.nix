{ pkgs, ... }:

{
  imports = [
    ./generic/pc.nix
    ./generic/virtualbox.nix
    ../modules-system/boot/bios.nix
    # ../modules-system/hardware/proprietary-drivers.nix
    # ../modules-system/build-emacs.nix
    # ../modules-system/build-emacs-gdb.nix
    # ../modules-system/hie.nix
  ];
}
