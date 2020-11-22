{pkgs, ...}:
{
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # programs.dconf.enable = true;

  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

  environment.systemPackages = with pkgs; [
    pulseeffects
  ];
}
