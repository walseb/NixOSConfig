{ pkgs, lib, ... }:

{
  imports = [
    ../system-modules/boot/uefi.nix
    ../system-modules/auto-upgrade-server.nix

    ../system-modules/hardware/proprietary-firmware/intel.nix
    ../system-modules/hardware/file-systems/ntfs-support.nix
    ../system-modules/hardware/SSD.nix
    ../system-modules/hardware/printer.nix

    ../system-modules/syncthing.nix
    # ../system-modules/network/wireguard-server.nix
    ../system-modules/network/sshd.nix

    (import ../system-modules/xorg/xorg-agenda.nix {pkgs = pkgs; xrandr-output = "HDMI-1"; file = "/home/admin/sync/org-agenda-img/agenda.html"; xrandr-extra = "--rotate left -s 1920x1080 --rate 50.00"; })
    ../system-modules/xorg/xorg-auto-login.nix
    ../system-modules/xorg/xorg-keep-screen-on.nix

    (import ../nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; address = (import ../nixos-private-config/servers.nix).mainServer; })

    ../system-modules/hardware/PrecisionClockMkII/nmea-time-service.nix
  ];
}
