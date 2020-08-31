{ pkgs, ... }:

{
  imports = [
    ../../system-modules/xorg.nix
    ../../system-modules/audio.nix
    ../../system-modules/hardware/backlight.nix
    ../../system-modules/wakelock.nix
    ../../system-modules/hardware/ntfs-support.nix
    ../../system-modules/mu.nix
  ];
}
