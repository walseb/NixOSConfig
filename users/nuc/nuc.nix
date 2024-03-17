{ pkg-s, lib, ... }:

{
  imports = [
    ../../modules-home/git.nix
    ../../modules-system/boot/uefi.nix
    ../../modules-system/boot/uefi.nix
    ../../modules-system/auto-upgrade-server.nix
    ../../modules-system/hardware/proprietary-firmware/intel.nix
    ../../modules-system/hardware/file-systems/ntfs-support.nix
    ../../modules-system/hardware/SSD.nix
    ../../modules-system/hardware/printer.nix
    ../../modules-system/syncthing.nix
    ../../modules-system/network/sshd.nix
    ../../modules-system/xorg/xorg-auto-login.nix
    ../../modules-system/xorg/xorg-keep-screen-on.nix

    # ../modules-system/network/wireguard-server.nix

    # (import ../modules-system/xorg/xorg-agenda.nix {pkg-s = pkg-s; xrandr-output = "HDMI-1"; file = "/home/admin/sync/org-agenda-img/agenda.html"; xrandr-extra = "--rotate left -s 1920x1080 --rate 50.00"; })
    # (import ../nixos-private-config/remote-file-server/remote-file-server.nix { pkg-s = pkg-s; lib = lib; address = (import ../nixos-private-config/servers.nix).mainServer; })

    # ../modules-system/hardware/PrecisionClockMkII/nmea-time.nix
  ];
}
