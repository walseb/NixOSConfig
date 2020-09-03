{ config, pkgs, ... }:

# Unstable packages
# let
#   unstable = import
#     (builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz)
#     # reuse the current configuration
#     { config = config.nixpkgs.config; };
# in
{
  system.stateVersion = "20.09";

  imports = [
    ./hardware-configuration.nix
    ./system-modules/cachix.nix
    ./system-device.nix
    ./system-modules/network/dns.nix
  ];

  cachix = [ ];

  nix = {
    # Needed to be able to use custom channels in home-manager
    trustedUsers = [ "root" "admin" ];

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
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = { "TIME_STYLE"  = "iso"; };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.emacs.defaultEditor = true;

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
