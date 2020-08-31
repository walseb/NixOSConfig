{ pkgs, ... }:

{
  imports = [
    ./generic/pc.nix
    ../system-modules/boot/bios.nix
    ../system-modules/virtualbox.nix
    # ../system-modules/hardware/proprietary-drivers.nix
    # ../system-modules/build-emacs.nix
    # ../system-modules/build-emacs-gdb.nix
    # ../system-modules/hie.nix
  ];
}
