{ pkg-s, ...}:
{
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.pulseaudio.package = pkg-s.pulseaudioFull;

  environment.systemPackages = with pkg-s; [
    pamixer
  ];

  imports = [
    # ./audio/pulseeffects.nix
    # ./jack.nix
  ];
}
