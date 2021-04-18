{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    xorg.xrandr
  ];

  imports = [
    ../system-modules/boot/uefi.nix
    ../system-modules/auto-upgrade-server.nix

    ../system-modules/hardware/proprietary-firmware/intel.nix
    ../system-modules/hardware/file-systems/ntfs-support.nix
    ../system-modules/hardware/SSD.nix
    ../system-modules/hardware/printer.nix

    ../system-modules/syncthing.nix
    ../system-modules/network/wireguard-server.nix
    ../system-modules/network/sshd.nix

    (import ../system-modules/xorg/xorg-agenda.nix {pkgs = pkgs; file = "/home/admin/sync/org-agenda-img/agenda.html"; })
    ../system-modules/xorg/xorg-auto-login.nix
    (import ../system-modules/xorg/xorg-keep-on.nix {pkgs = pkgs; extraConfig = "${pkgs.xrandr}/bin/xrandr --output HDMI-1 --rotate left -s 1920x1080 --rate 50.00";})

    (import ../nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; address = (import ../nixos-private-config/servers.nix).mainServer; })
  ];
}
