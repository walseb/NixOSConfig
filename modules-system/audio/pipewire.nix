{ pkgs, ... }:
{
  imports =
    [
      ./easyeffects-pipewire.nix
    ];

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      # support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;

  };
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  environment.systemPackages = with pkgs; [
    # I think this includes easyeffects
    pulseaudioFull
    pamixer
  ];
}
