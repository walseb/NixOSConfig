{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "carpalx";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
     # xorg.xauth 
     # xorg.xinit
     xorg.setxkbmap
     xorg.xrandr
     
     mono guile
     mlocate atool unzip ag imagemagick wget
 
     aspell aspellDicts.en aspellDicts.sv
 
     mpd mpc_cli
 
     htop
 
     poppler
 
     # Applications
     emacs firefox git redshift 

     # Security
     gnupg pinentry_emacs

     # Virtualbox
     linuxPackages.virtualboxGuestAdditions
  ];

# Add binary caches
nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

# Add if fonts are missing
#pkgs.dejavu_fonts
fonts.fonts = [ pkgs.inconsolata-lgc pkgs.open-sans ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

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

services.xserver = {
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
        ${pkgs.emacs}/bin/emacs &
        waitPID=$!
    '';
    }];
};

# Enable the locate service, it doesn't work otherwise
services.locate = {
    enable = true;
    # just never auto update the database, they use cron as a to run locate at time intervals, this expression makes it never evauate (unless the year is 3099)
    interval = "0 0 0 1 1 ? 3099";
};
#users.mutableUsers = false;
# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    #"mlocate" 
    password = "";   
};

  system.stateVersion = "19.03";
}
