{
  imports = [
    ./grub.nix
  ];

  # Enable EFI support
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.systemd-boot.enable = true;
}
