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

    # When pressing left and right mouse button together, emulate middle click
    middleEmulation = true;
    # middleEmulation = false;
    # naturalScrolling = true;
  };
}
