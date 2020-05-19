{ config, pkgs, ... }:

# let
#   unstableTarball = fetchTarball
#     "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
# in
{
  imports = [ ./hardware-configuration.nix ./device.nix ];

  system.stateVersion = "20.03";
  # system.autoUpgrade.enable = true;

  # Add binary caches
  nix.useSandbox = true;
  nix.binaryCaches =
    [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys =
    [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  nixpkgs.config = {
    # Enable use of nixos unstable
    # packageOverrides = pkgs: {
    #   unstable = import unstableTarball { config = config.nixpkgs.config; };
    # };

    # allowBroken = true;
    allowUnfree = false;
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
  ];

  fonts.fonts = [
    # pkgs.fira-code
    (import ./hw-configs/modules/fonts/my-inconsolata-lgc.nix)
  ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Clean /tmp on boot
  boot.cleanTmpDir = true;
  # Make /tmp be in ram
  boot.tmpOnTmpfs = true;
  boot.loader.timeout = 1;

  # Hibernate after 1 hour of sleep
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

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

    xserver = {
      enable = true;
      layout = "us";

      # Allow exwm to work
      displayManager.sessionCommands =
        "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";

      libinput.enable = true;

      # Disable mouse acceleration for touchpad
      libinput.accelProfile = "flat";

      # Disable mouse acceleration for mouse
      config = ''
        Section "InputClass"
          Identifier "mouse accel"
          Driver "libinput"
          MatchIsPointer "on"
          Option "AccelProfile" "flat"
          Option "AccelSpeed" "0"
        EndSection
      '';

      # displayManager.session = [{
      #   manage = "desktop";
      #   name = "st";
      #   # https://lists.suckless.org/hackers/1611/13652.html
      #   start = ''
      #     st -e /bin/bash --login &
      #     waitPID=$!
      #   '';
      # }];

      displayManager.session = 
        [ { manage = "desktop";
            name = "xterm";
            start = ''
            ${pkgs.xterm}/bin/xterm -ls &
            waitPID=$!
          '';
          }
        ];

      desktopManager.session = [
        {
          manage = "desktop";
          name = "emacs";
          start = ''
            emacs &
            waitPID=$!
          '';
        }

        {
          manage = "desktop";
          name = "emacs-docked";
          start = ''
            emacs -my/docked &
            waitPID=$!
          '';
        }
      ];

      #  Set emacs as default entry
      displayManager.defaultSession = "emacs";

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
    mutableUsers = true;
  };
}
