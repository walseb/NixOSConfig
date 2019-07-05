# This install an arbritary ghc version
# nix-shell -p haskell.compiler.ghcXYZ

{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  system.stateVersion = "19.03";

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # ./build.nix
  ];

  hardware = {
    # enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu = {
      amd.updateMicrocode = true;
      intel.updateMicrocode = true;
    };
  };
  # for skype
  # hardware.pulseaudio.enable = true;

  nixpkgs.config = {
    packageOverrides = pkgs: {
      emacs = (pkgs.emacs.override { srcRepo = true; imagemagick = false; }).overrideAttrs (old: rec {
        name = "emacs-${version}${versionModifier}";
        version = "27.0.50";
        versionModifier = "-git";
        src = pkgs.fetchFromGitHub {
          owner = "emacs-mirror";
          repo = "emacs";

          rev = "e751431989f0af69a7eabf26a86ccac8d8aab74f";
          sha256 = "0alb8g9bflkk5yy5wrk069ihbwynyib2wilz36125ibs7p6l084h";
        };
        patches = [];
      });


      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Add binary caches
  nix.useSandbox = true;
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  environment.systemPackages = with pkgs; [
    # xorg.xauth 
    # xorg.xinit
    xorg.setxkbmap
    xorg.xrandr

    unstable.mono unstable.guile unstable.gcc

    mlocate atool unzip ag unstable.imagemagick wget openssh ffmpeg p7zip


    aspell aspellDicts.en aspellDicts.sv

    mpd mpc_cli
    htop
    poppler

    # Haskell
    ghc cabal-install cabal2nix 
    # Broken
    # haskellPackages.halive 

    # Haskell editor
    hlint haskellPackages.hoogle


    #binutils

    # Install stable HIE for GHC845 (GHC 864 and 863 is commented out). Looks like the binaries only exist for stable versions of ghc (ghc864)
    (all-hies.selection { selector = p: { inherit (p) /* ghc864 ghc863 */ ghc864; }; })

    # Applications
    emacs 
    plasma-browser-integration
    firefox unstable.git unstable.git-lfs unstable.redshift unstable.gimp mpv
    pavucontrol

    harfbuzz

    dovecot

    direnv

    # Security
    gnupg unstable.pinentry_emacs

    # Virtualbox
    linuxPackages.virtualboxGuestAdditions
  ];

  fonts.fonts = [ pkgs.inconsolata-lgc pkgs.dejavu_fonts ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Enable EFI support
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable BIOS support
  boot.loader.grub.device = "/dev/sda";

  boot.kernelParams = [ "nomodeset" ];
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  #  i18n.consoleFont = "Lat2-Terminus16";
  #  i18n.consoleKeyMap = "carpalx";
  #  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  #  services.xserver.displayManager.lightdm.enable = false;

# services.dovecot2


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
        # systemd[1]: Starting Physlock...
        # physlock-start[774]: physlock: Unable to detect user of tty1
        # extraTargets = ["display-manager.service"];
      };
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      forwardX11 = true;
    };

    xserver = {
      enable = true;
      #autorun = false;
      layout = "us";
      #displayManager.lightdm.enable = true;
      #desktopManager.default = "none";

      # Allow exwm to work
      displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";

      #  Set emacs as default entry
      desktopManager.default = "emacs";
      desktopManager.session = [ {
        manage = "desktop";
        name = "emacs";
        start = ''
          #${pkgs.emacs}/bin/emacs &
          emacs &
          waitPID=$!
        '';
      }];
    };

    # Enable the locate service, it doesn't work otherwise
    locate = {
      enable = true;
      # just never auto update the database, they use cron as a to run locate at time intervals, this expression makes it never evauate (unless the year is 3099)
      interval = "0 0 0 1 1 ? 3099";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
  };

  users = {
    extraUsers.admin = {
      group = "users";

      isNormalUser = true;
      # extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      uid = 1000;
      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" ];
      #"mlocate" 
      password = "";   
    };
    mutableUsers = true;
  };
}
