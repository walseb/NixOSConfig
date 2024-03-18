{ pkgs, pkg-s-path, pkg-s, lib, ... }:

let
  # Generate using mkpasswd -m sha-512
  my-nat-addr = "10.100.0.2/32";
in
{
  # boot.kernelPackages = pkgs.linuxPackages_latest;


  networking = {
    # Cold War Assault
    firewall.allowedTCPPorts = [27015 27036 8000 8001 80 6530];
    firewall.allowedUDPPorts = [2302 2303 2304  2305  27015  27031  27032 27033 27034 27035 27036 8000 8001 80 6530];
  };
  # Swap only when needed
  # https://unix.stackexchange.com/questions/265713/how-to-configure-swappiness-in-linux-memory-management
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;

  };


  imports = [
    ../generic/workstation-system.nix

    ../../modules-system/kernel.nix

    ../../modules-system/hardware/SSD.nix

    ../../modules-system/network/dns.nix
    ../../modules-system/virt-manager.nix

    (import ../../modules-system/nix.nix {inherit pkgs; inherit pkg-s-path; inherit pkg-s; inherit lib; max-jobs = 2;})

    ../../modules-system/file-server/http-file-server.nix

    ./hardware-configuration.nix

    # ./generic/midi.nix
    # (import ./generic/pc.nix { mouse-acceleration = false; pkgs = pkgs; })
    ../generic/laptop.nix
    # (import ../modules-system/boot/bios.nix { grub-dev = "/dev/nvme0n1"; })
    ../../modules-system/boot/uefi.nix
    ../../modules-system/vm/ios.nix

    # ../modules-system/webcam-loopback.nix

    ../../modules-system/hardware/printer-network.nix
    ../../modules-system/hardware/bluetooth.nix

    ../../modules-system/hardware/tlp/tlp-intel-laptop-performance.nix

    # ../modules-system/hardware/proprietary-firmware/amd.nix # ../modules-system/hardware/proprietary-firmware/all-firmware.nix
    ../../modules-system/hardware/proprietary-firmware/intel.nix
    # ../modules-system/hardware/proprietary-firmware/redistributable-firmware.nix
    # ../modules-system/hardware/proprietary-firmware/all-firmware.nix

    ../../modules-system/hardware/graphics/vulkan.nix
    # ../modules-system/hardware/graphics/amd-video.nix
    ../../modules-system/hardware/graphics/intel-video.nix

    ../../modules-system/syncthing.nix
    # ../modules-system/redshift.nix

    # ../modules-system/hardware/input/synaptics.nix
    ../../modules-system/hardware/input/libinput.nix


    ../../modules-system/steam.nix


    # ./hw-configs/x200-libreboot.nix
    # ./hw-configs/home-vm.nix
    # ./hw-configs/vps.nix
    # ./hw-configs/ideapad.nix

    # (import ./nixos-private-config/remote-file-server/aws.nix { pkgs = pkgs; lib = lib; })


    # (import ./nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; })
    # (import ./nixos-private-config/remote-file-server/remote-file-server.nix { pkgs = pkgs; lib = lib; address = "127.0.0.1"; })


    # ./cachix.nix
    # ./hw-configs/modules/hie.nix

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

  # services.syncthing.relay.enable = true;
  # services.syncthing.relay.port = 22240;
  # services.syncthing.relay.statusPort = 22241;
  # # [22 80]
  # networking.firewall.allowedTCPPorts = [22240 22241];

  programs.kdeconnect.enable = true;

  # services.xserver.desktopManager.plasma5.enable = true;

  # https://github.com/NixOS/nixos-hardware/blob/master/lenovo/thinkpad/t480/default.nix
  services.throttled.enable = true;

  services.xserver.libinput.touchpad.calibrationMatrix = "2, 0, 0, 0, 2, 0, 0, 0, 1";
  services.xserver.libinput.mouse.calibrationMatrix = "2, 0, 0, 0, 2, 0, 0, 0, 1";

  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  services.undervolt.coreOffset = -100;
  services.undervolt.enable = true;

  environment.systemPackages = with pkg-s; [
    plasma-browser-integration
    plasma-integration
    # home-manager
    # inkscape

    # inkcut-new
    # inkscape-my-extensions
    # (inkscape-with-extensions {inkscapeExtensions = [inkscape-silhouette inkscape-extensions.inkcut];})
    # (import ./modules-system/inkscape/inkscape-extensions-proxy.nix {lib = lib; inkscape = pkgs.inkscape; symlinkJoin = symlinkJoin; makeWrapper = makeWrapper; inkscapeExtensions = [inkscape-silhouette]; inkscape-extensions = null;})
    # inkscape-silhouette

    # (import ./modules-home/games/cortex.nix)

  ];
}
