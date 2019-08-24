# This install an arbritary ghc version
# nix-shell -p haskell.compiler.ghcXYZ

{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
    ./device.nix
  ];

  system.stateVersion = "19.03";

  # Add binary caches
  nix.useSandbox = true;
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  nixpkgs.config = {
    # Enable use of nixos unstable
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # xorg.xauth 
    # xorg.xinit
    xorg.setxkbmap
    xorg.xrandr
    xorg.xkbcomp

    unstable.mono
    unstable.guile
    unstable.gcc

    networkmanager
    networkmanagerapplet # this comment fixes the emacs nix-mode formatter: in

    unstable.wget
    unstable.openssh

    ag

    atool
    unzip
    p7zip

    unstable.aspell
    unstable.aspellDicts.en
    unstable.aspellDicts.sv
    languagetool

    unstable.mpd
    unstable.mpc_cli

    htop

    imagemagick
    ffmpeg

    unstable.w3m

    # Needed by cabal?
    binutils

    # Haskell
    ghc
    cabal-install
    cabal2nix
    cachix
    stack
    hlint
    haskellPackages.hoogle
    unstable.haskellPackages.brittany

    # Used by hlint-refactor-mode
    # haskellPackages.apply-refact

    # Broken
    # haskellPackages.halive 

    # Install HIE for ghc864
    (all-hies.selection { selector = p: { inherit (p) /* ghc863 */ ghc864; }; })

    # unstable.haskellPackages.ghc-imported-from
    # Applications
    emacs
    haskellPackages.structured-haskell-mode
    unstable.harfbuzz
    pinentry_emacs 
    # pdftools
    poppler
    # libvterm
    cmake
    libtool
    gnumake
    libvterm

    firefox
    plasma-browser-integration

    unstable.git
    unstable.git-lfs
    unstable.redshift

    unstable.gimp

    mpv
    pavucontrol

    # mail
    dovecot
    unstable.isync
    unstable.msmtp

    unstable.direnv

    # Security
    unstable.gnupg

    # Virtualbox
    linuxPackages.virtualboxGuestAdditions
  ];

  fonts.fonts = [ pkgs.inconsolata-lgc pkgs.dejavu_fonts ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    emacs.defaultEditor = true;

    dovecot2.enable = true;
    dovecot2.configFile = "/etc/nixos/dovecot.conf";
    # TODO when fixing this. The password files are all read/write only to user admin, this would have to change if dovecot got to use it's own user. Also update the docs in config.el about this change
    dovecot2.user = "admin";
    dovecot2.group = "users";

    physlock = {
      enable = true;
      lockOn = {
        suspend = true;
        hibernate = true;
      };
    };

    openssh = {
      enable = true;
      forwardX11 = true;
    };

    xserver = {
      enable = true;
      layout = "us";

      # Allow exwm to work
      displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";

      #  Set emacs as default entry
      desktopManager.default = "emacs";

      desktopManager.session = [ {
        manage = "desktop";
        name = "emacs";
        start = ''
          emacs &
          waitPID=$!
        '';
      }];
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

