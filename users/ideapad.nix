{ pkgs, stdenv, lib, ...}:
let
  # Generate using mkpasswd -m sha-512
  pass = "$6$emDF9qEWb4Q$VWmHX4lcEbMjC6xqr6h31QttnRUz.jMxpL1xFefXc5jiLOrSrobfrAy1lTxo4PqjCfG41sXoSVXEmveB.3E5S/";
  my-nat-addr = "10.100.0.2/32";
in
{
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [
    ./generic/pc.nix
    # ./generic/midi.nix
    # (import ./generic/pc.nix { mouse-acceleration = false; pkgs = pkgs; })
    ./generic/laptop.nix
    # (import ../modules-system/boot/bios.nix { grub-dev = "/dev/nvme0n1"; })
    ../modules-system/boot/uefi.nix

    # ../modules-system/webcam-loopback.nix

    ../modules-system/hardware/printer-network.nix
    ../modules-system/hardware/bluetooth.nix

    ../modules-system/hardware/tlp/tlp-amd.nix

    ../modules-system/hardware/proprietary-firmware/amd.nix # ../modules-system/hardware/proprietary-firmware/all-firmware.nix
    # ../modules-system/hardware/proprietary-firmware/redistributable-firmware.nix
    # ../modules-system/hardware/proprietary-firmware/all-firmware.nix

    ../modules-system/hardware/graphics/vulkan.nix
    ../modules-system/hardware/graphics/amd-video.nix

    ../modules-system/syncthing.nix
    # ../modules-system/redshift.nix

    ../modules-system/hardware/input/libinput.nix

    # ./users/x200-libreboot.nix
    # ./users/home-vm.nix
    # ./users/vps.nix
    # ./users/ideapad.nix

    ./modules-system/steam.nix

    # (import ./nixos-private-config/remote-file-server/aws.nix { pkgs = pkgs; lib = lib; })


    # (import ./nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; })
    # (import ./nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; address = "127.0.0.1"; })


    # ./cachix.nix
    # ./users/modules/hie.nix

    # ./modules-system/VPS/nextcloud.nix
    # ./modules-system/VPS/nextcloud.nix

    # ./modules-system/network/wireguard-server.nix
    # (import ./modules-system/network/wireguard-client.nix { nat-addr = my-nat-addr; })
    # (import ./nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; address = (import ./nixos-private-config/servers.nix).mainServer; })
    # ./nixos-private-config/remote-file-server/remote-file-server.nix
    # ./modules-system/xorg/xorg-keep-on.nix

    # (import ./modules-system/inkscape/inkscape-silhouette.nix {lib= lib; python3Packages = pkgs.python3Packages; fetchFromGitHub = pkgs.fetchFromGitHub; wrapQtAppsHook = pkgs.wrapQtAppsHook; cups = lib.cups; })
    # (import ./modules-system/inkscape/inkscape-my-extensions.nix {inkscape-silhouette = (import ./modules-system/inkscape/inkscape-silhouette.nix {lib= lib; python3Packages = pkgs.python3Packages; fetchFromGitHub = lib.fetchFromGitHub;wrapQtAppsHook = lib.wrapQtAppsHook; cups = lib.cups; });})
  ];

  networking.hostName = "nixos";

  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      password = "1";
      # hashedPassword = pass;

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" "uinput" "lp" ];
    };
    users.root = {
      # password = "1";
      hashedPassword = pass;
    };

    mutableUsers = false;
  };

  # services.syncthing.relay.enable = true;
  # services.syncthing.relay.port = 22240;
  # services.syncthing.relay.statusPort = 22241;
  # # [22 80]
  # networking.firewall.allowedTCPPorts = [22240 22241];
  
  programs.kdeconnect.enable = true;

  # services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    plasma-browser-integration
    plasma-integration
    home
    # inkscape

    # inkcut-new
    # inkscape-my-extensions
    # (inkscape-with-extensions {inkscapeExtensions = [inkscape-silhouette inkscape-extensions.inkcut];})
    # (import ./modules-system/inkscape/inkscape-extensions-proxy.nix {lib = lib; inkscape = pkgs.inkscape; symlinkJoin = symlinkJoin; makeWrapper = makeWrapper; inkscapeExtensions = [inkscape-silhouette]; inkscape-extensions = null;})
    # inkscape-silhouette

    # (import ./modules-home/games/cortex.nix)

  ];

  nix.settings.max-jobs = 1;

  services.xserver.libinput.touchpad.calibrationMatrix = "2, 0, 0, 0, 2, 0, 0, 0, 1";
  services.xserver.libinput.mouse.calibrationMatrix = "2, 0, 0, 0, 2, 0, 0, 0, 1";

  # hardware.usbWwan.enable = true;
}
