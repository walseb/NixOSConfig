{ pkgs, ... }:

{
  imports = [
    ./modules/boot/bios.nix
    ./modules/virtualbox.nix
    ./modules/hardware/proprietary-drivers.nix
    # ./modules/build-emacs.nix
    # ./modules/build-emacs-gdb.nix
    # ./modules/hie.nix
  ];

  environment.systemPackages = with pkgs; [
    wakatime
  ];
}
