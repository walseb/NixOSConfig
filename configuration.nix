{ pkg-s, nixos-version, ... }:

{
  system.stateVersion = nixos-version;

  networking = {
    networkmanager.enable = true;

    # Cold War Assault
    firewall.allowedTCPPorts = [27015 27036 8000 8001 80 6530];
    firewall.allowedUDPPorts = [2302 2303 2304  2305  27015  27031  27032 27033 27034 27035 27036 8000 8001 80 6530];

    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  # services.openssh = {
  #   enable = true;
  #   extraConfig = "GatewayPorts yes";
  #   ports = [6530 22];
  # };

  imports = [
    ./modules-system/virt-manager.nix

    ./modules-system/cachix.nix
    # ./modules-system/chromium.nix
    ./modules-system/network/dns.nix
    # ./modules-system/network/dns-crypt.nix
    # ./modules-system/tty.nix
    ./modules-system/firefox.nix

    ./modules-system/imagemagick.nix

    ./modules-system/clipmenu.nix

    ./modules-system/portal.nix

    ./modules-system/android.nix

    ./modules-system/languagetool.nix

    ./modules-system/kernel.nix

    ./modules-system/obs.nix

    # ./modules-system/keyboard-rebind.nix
    # ./modules-system/gpaste.nix
  ];

  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      password = "1";
      # hashedPassword =  "$6$emDF9qEWb4Q$VWmHX4lcEbMjC6xqr6h31QttnRUz.jMxpL1xFefXc5jiLOrSrobfrAy1lTxo4PqjCfG41sXoSVXEmveB.3E5S/";

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" "uinput"

                      # Printer
                      "lp"

                      # VM
                      "libvirt" "libvirtd" "kvm" "input" ];
    };
    users.root = {
      password = "1";
      # hashedPassword =  "$6$emDF9qEWb4Q$VWmHX4lcEbMjC6xqr6h31QttnRUz.jMxpL1xFefXc5jiLOrSrobfrAy1lTxo4PqjCfG41sXoSVXEmveB.3E5S/";
    };

    mutableUsers = false;
  };

  # For some reason, this is needed
  cachix = [ ];

  services.journald.extraConfig = "SystemMaxUse=100M";

  # services.clamav.daemon.enable = true;

  # Swap only when needed
  # https://unix.stackexchange.com/questions/265713/how-to-configure-swappiness-in-linux-memory-management
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;

    # "net.ipv4.conf.all.forwarding" = 1;
    # "net.ipv4.conf.all.route_localnet" = 1;
    # "net.ipv4.conf.default.forwarding" = 1;

    # Allows the user to bind lower range addresses
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };


  boot.tmp = {
    # Clean /tmp on boot
    cleanOnBoot = true;
    # Make /tmp be in ram
    useTmpfs = true;
    tmpfsSize = "90%";
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

  i18n.extraLocaleSettings = { "TIME_STYLE" = "+%d-%m-%Y %H:%M"; };
  # i18n.extraLocaleSettings = { "TIME_STYLE" = "iso"; };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
  # time.timeZone = "Australia/Sydney";

  documentation = {
    # services.emacs.defaultEditor = true;

    # documentation.enable = true;
    # documentation.man.generateCaches = true;
    # documentation.man.enable = true;
    info.enable = true;
    doc.enable = true;
    nixos.enable = true;
  };
  # documentation.man.man-db.enable = true;

  environment.systemPackages = with pkg-s; [
    # Needed by book maker automation
    librsvg


    stack
    # Needed for KDP cover maker
    texlive.combined.scheme-medium

    # Needed for PDF jam
    # texliveMedium
    # ocamlPackages.cpdf

    nix-prefetch-git

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

    gcc
    zlib
  ];
}
