{ config, pkgs, ... }:

# let
#   unstableTarball = fetchTarball
#     "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
# in
{
  system.stateVersion = "20.03";

  imports = [ ./hardware-configuration.nix
              ./device.nix
              ./modules/dns.nix
              ./modules/xorg.nix
              ./modules/audio.nix
            ];

  # system.autoUpgrade.enable = true;

  # Add binary caches
  nix.useSandbox = true;
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  nixpkgs.config = {
    # Enable use of nixos unstable
    # packageOverrides = pkgs: {
    #   unstable = import unstableTarball { config = config.nixpkgs.config; };
    # };

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
    emacs.defaultEditor = true;
    physlock = {
      enable = true;
      lockOn = {
        suspend = true;
        hibernate = true;
      };
    };

    openssh = { forwardX11 = true; };
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

    brightnessctl

    networkmanager
    networkmanagerapplet

    wget
    openssh

    st

    # Needs to be installed here to work properly
    ntfs3g

    mu
  ];
}
