{ pkg-s, ... }:
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
  hardware.pulseaudio.package = pkg-s.pulseaudioFull;

  environment.systemPackages = with pkg-s; [
    # I think this includes easyeffects
    pulseaudioFull
    pamixer
  ];
}
