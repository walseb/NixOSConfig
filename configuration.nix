{ config, pkgs, ... }:

let
  caches = [
    "https://cache.nixos.org/"

    "https://nixcache.reflex-frp.org"

    # Haskell.nix
    "https://hydra.iohk.io"

    "https://nix-community.cachix.org"
  ];

  cachesKeys = [
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="

    # haskell.nix
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="

    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
in {
  system.stateVersion = "20.09";

  imports = [
    ./hardware-configuration.nix
    ./system-modules/cachix.nix
    ./system-device.nix
    ./system-modules/network/dns.nix
    # ./system-modules/tty.nix
  ];

  cachix = [ ];

  nix = {
    # package = pkgs.nixUnstable;

    # Don't garbage collect nix-shell
    extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';

    # Needed to be able to use custom channels in home-manager
    trustedUsers = [ "root" "admin" ];

    # Add binary caches
    # useSandbox = true;
    trustedBinaryCaches = caches;
    binaryCaches = caches;
    binaryCachePublicKeys = cachesKeys;
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
  i18n.extraLocaleSettings = { "TIME_STYLE" = "iso"; };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  networking.networkmanager.enable = true;

  services.emacs.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    htop

    git

    networkmanager
    networkmanagerapplet

    wget

    # Required to use cachix
    cachix

    # Needs to be system-wide by org-roam
    sqlite

    xorg.libxcb
    libdrm

    chromium
  ];
}
