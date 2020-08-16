# https://github.com/jonascarpay/nix

{ config, pkgs, ... }:

# Unstable packages
# let
#   unstable = import
#     (builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz)
#     # reuse the current configuration
#     { config = config.nixpkgs.config; };
# in
{
  system.stateVersion = "20.03";

  imports = [
    ./hardware-configuration.nix
    ./system-modules/cachix.nix
    ./system-device.nix
    ./system-modules/dns.nix
    ./system-modules/xorg.nix
    ./system-modules/audio.nix
    ./system-modules/hardware/backlight.nix
  ];

  cachix = [ ];
  # (import ./cachix-caches.nix);

  # system.autoUpgrade.enable = true;
  # nix.gc.automatic

  # Add binary caches
  nix.useSandbox = true;
  nix.binaryCaches =
    [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys =
    [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  # Needed to be able to use custom channels in home-manager
  nix.trustedUsers = [ "root" "admin" ];

  nixpkgs.config = {
    # allowBroken = true;
    allowUnfree = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Clean /tmp on boot
  boot.cleanTmpDir = true;
  # Make /tmp be in ram
  boot.tmpOnTmpfs = true;

  boot.loader.timeout = 1;

  services = {
    lorri.enable = true;

    emacs.defaultEditor = true;
    physlock = {
      enable = true;
      lockOn = {
        suspend = true;
        hibernate = true;
      };
    };
  };

  users = {
    extraUsers.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      password = "";

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" ];
    };
    mutableUsers = false;
  };

  environment.systemPackages = with pkgs; [
    # xorg.xauth 
    # xorg.xinit
    xorg.setxkbmap
    xorg.xrandr
    autorandr
    xorg.xkbcomp

    htop

    networkmanager
    networkmanagerapplet

    wget
    openssh

    st

    # Needs to be installed here to work properly
    ntfs3g

    # This doesn't have the elisp if you put it in home-manager
    mu

    # Required to use cachix
    cachix
  ];
}
