{ pkgs, ...}:
{
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

  imports = [
    ./audio/pulseeffects.nix
  ];
}
