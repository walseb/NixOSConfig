{ pkg-s, nixos-version, ... }:

{
  system.stateVersion = nixos-version;

  boot.loader.timeout = 1;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # services.openssh = {
  #   enable = true;
  #   extraConfig = "GatewayPorts yes";
  #   ports = [6530 22];
  # };

  imports = [
    ./modules-system/polkit.nix
    ./modules-system/cachix.nix
    # ./modules-system/network/dns-crypt.nix
  ];

  # For some reason, this is needed
  cachix = [ ];

  services.journald.extraConfig = "SystemMaxUse=100M";

  # services.clamav.daemon.enable = true;

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

  # documentation = {
  #   # documentation.enable = true;
  #   # documentation.man.generateCaches = true;
  #   # documentation.man.enable = true;
  #   info.enable = true;
  #   doc.enable = true;
  #   nixos.enable = true;
  # };
  # # documentation.man.man-db.enable = true;
  environment.systemPackages = with pkg-s; [
    vim
  ];


  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
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
}
