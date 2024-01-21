{ pkgs, stdenv, callPackage, ... }:

{
  system.stateVersion = "23.11";

# Cold War Assault
  networking.firewall.allowedTCPPorts = [27015 27036 8000 8001 80];
  networking.firewall.allowedUDPPorts = [2302 2303 2304  2305  27015  27031  27032 27033 27034 27035 27036 8000 8001 80];

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];


  imports = [
    # ./nix.nix
    ./modules-system/cachix.nix
    # ./modules-system/chromium.nix
    ./modules-system/network/dns.nix
    # ./modules-system/network/dns-crypt.nix
    # ./modules-system/tty.nix
    ./modules-system/firefox.nix

    ./modules-system/imagemagick.nix

    ./modules-system/clipmenu.nix

    ./modules-system/android.nix

    ./modules-system/languagetool.nix

    ./modules-system/kernel.nix

    # ./modules-system/keyboard-rebind.nix
    # ./modules-system/gpaste.nix
  ];

  cachix = [ ];

  services.journald.extraConfig = "SystemMaxUse=100M";

  nixpkgs.config = {
    # allowBroken = true;
    allowUnfree = true;
  };
  # services.clamav.daemon.enable = true;

  boot.tmp = {
    # Clean /tmp on boot
    cleanOnBoot = true;
    # Make /tmp be in ram
    useTmpfs = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  # https://github.com/NixOS/nixpkgs/issues/179486
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = { "TIME_STYLE" = "iso"; };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
  # time.timeZone = "Australia/Sydney";

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
