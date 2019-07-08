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

      # Install emacs git
      emacs = (pkgs.emacs.override { srcRepo = true; imagemagick = false; }).overrideAttrs (old: rec {
        name = "emacs-${version}${versionModifier}";
        version = "27.0.50";
        versionModifier = "-git";
        src = pkgs.fetchFromGitHub {
          owner = "emacs-mirror";
          repo = "emacs";

          rev = "dde0320020429a2d2917895fc0e2f5a24ffe6348";
          sha256 = "1xnjxmd8bdi01wdqshl5w613xb5v2i9f1hm33hharggmnpwydr2q";
        };
        patches = [];
      });
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

    unstable.networkmanager
    unstable.networkmanagerapplet # this fixes the emacs nix-mode formatter: in

    unstable.wget
    unstable.openssh

    unstable.ag

    unstable.atool
    unstable.unzip
    unstable.p7zip

    unstable.aspell
    unstable.aspellDicts.en
    unstable.aspellDicts.sv

    unstable.mpd
    unstable.mpc_cli

    unstable.htop
    unstable.poppler

    unstable.imagemagick
    unstable.ffmpeg

    # Needed by cabal?
    binutils

    # Haskell
    ghc
    cabal-install
    cabal2nix
    stack
    hlint
    haskellPackages.hoogle
    cachix
    # Broken
    # haskellPackages.halive 

    # Install HIE for ghc864
    (all-hies.selection { selector = p: { inherit (p) /* ghc864 ghc863 */ ghc864; }; })

    # Applications
    emacs
    unstable.harfbuzz
    pinentry_emacs 

    firefox
    plasma-browser-integration

    unstable.git
    unstable.git-lfs
    unstable.redshift
    unstable.gimp
    unstable.mpv

    unstable.pavucontrol
    unstable.dovecot

    unstable.direnv

    # Security
    unstable.gnupg

    # Virtualbox
    linuxPackages.virtualboxGuestAdditions
  ];

  fonts.fonts = [ pkgs.inconsolata-lgc pkgs.dejavu_fonts ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Enable EFI support
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable BIOS support
  boot.loader.grub.device = "/dev/sda";

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

    # SMART.
    smartd = {
      enable = true;
      devices = [{ device = "/dev/sda"; }];
      notifications.test = true;
      notifications.x11.enable = true;
    };
    fstrim.enable = true;

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
