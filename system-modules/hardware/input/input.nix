{
  services.xserver.libinput.enable = true;

  imports = [
    ./no-mouse-acceleration.nix
  ];
}
