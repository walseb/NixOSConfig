{
  services.xserver.synaptics.enable = false;
  services.xserver.libinput.enable = true;

  imports = [
    ./no-mouse-acceleration.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/hardware/libinput.nix
  services.xserver.libinput.touchpad = {
    # scrollMethod = "twofinger";
    # "button" 
    middleEmulation = false;
    # naturalScrolling = true;
  };
}
