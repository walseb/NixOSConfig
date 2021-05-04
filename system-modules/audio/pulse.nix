{ pkgs, ...}:
{
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

  environment.systemPackages = with pkgs; [
    pamixer
  ];

  imports = [
    # ./audio/pulseeffects.nix
    # ./jack.nix
  ];
}
