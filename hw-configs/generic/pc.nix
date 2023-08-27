{  pkgs, ... }:
{
  boot.loader.timeout = 1;

  imports = [
    ../../modules-system/xorg/xorg.nix
    # ../../modules-system/audio/pulse.nix
    # ../../modules-system/audio/jack.nix
    ../../modules-system/audio/pipewire.nix
    ../../modules-system/hardware/backlight.nix
    ../../modules-system/wakelock.nix
    ../../modules-system/hardware/file-systems/ntfs-support.nix
    # ../../modules-system/mu.nix
    # ../../modules-system/auto-upgrade.nix
    ../../modules-system/fonts/font.nix
    ../../modules-system/polkit.nix
  ];
}
