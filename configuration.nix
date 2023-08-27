{ pkgs, stdenv, callPackage, ... }:

{
  system.stateVersion = "23.05";

  imports = [
    ./nix.nix
    ./system-device.nix
    ./hardware-configuration.nix
    ./modules-system/cachix.nix
    # ./modules-system/chromium.nix
    ./modules-system/network/dns.nix
    # ./modules-system/tty.nix
    ./modules-system/firefox.nix

    ./modules-system/imagemagick.nix

    ./modules-system/clipmenu.nix

    # ./modules-system/keyboard-rebind.nix
    # ./modules-system/gpaste.nix
  ];

  cachix = [ ];

  nixpkgs.config = {
    # allowBroken = true;
    allowUnfree = true;
  };

  boot.tmp = {
    # Clean /tmp on boot
    cleanOnBoot = true;
    # Make /tmp be in ram
    useTmpfs = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  # https://github.com/NixOS/nixpkgs/issues/179486
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = { "TIME_STYLE" = "iso"; };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "Australia/Sydney";

  networking.networkmanager.enable = true;

  # services.emacs.defaultEditor = true;

  # documentation.enable = true;
  # documentation.man.generateCaches = true;
  # documentation.man.enable = true;
  documentation.info.enable = true;
  documentation.doc.enable = true;
  documentation.nixos.enable = true;
  # documentation.man.man-db.enable = true;

  environment.systemPackages = with pkgs; [
    # gpaste-1
    lutris

    chromedriver

    htop

    git

    networkmanager
    networkmanagerapplet

    wget

    # Required to use cachix
    cachix

    # Needed for opengl?
    xorg.libxcb

    killall

    glslang
    shaderc

    SDL2
    # ydotool

    vim
  ];
}
