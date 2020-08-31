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
  ];

  cachix = [ ];

  # system.autoUpgrade.enable = true;

  nix = {
    # Needed to be able to use custom channels in home-manager
    trustedUsers = [ "root" "admin" ];

    # gc.automatic

    # Add binary caches
    useSandbox = true;
    binaryCaches =
      [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
    binaryCachePublicKeys =
      [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  };

  nixpkgs.config = {
    # allowBroken = true;
    allowUnfree = false;
  };

  boot = {
    # Clean /tmp on boot
    cleanTmpDir = true;
    # Make /tmp be in ram
    tmpOnTmpfs = true;

    loader.timeout = 1;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = { "TIME_STYLE"  = "iso"; };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.emacs.defaultEditor = true;

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
    htop

    networkmanager
    networkmanagerapplet

    wget
    openssh

    # Required to use cachix
    cachix
  ];
}
