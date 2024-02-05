# https://github.com/magnetophon/nixosConfig/blob/master/music.nix
{pkg-s, ...}:
{
  imports = [
    # ./musnix.nix
  ];

  # sound.enable = true;
  # services.jack.alsa.enable = true;
  # services.jack.jackd.enable = true;

  # hardware.pulseaudio.package = pkg-s.pulseaudio.override { jackaudioSupport = true; };

  environment.systemPackages = with pkg-s; [
    jack2Full
    qjackctl
  ];

  systemd.services.jack = {
    after = [ "sound.target" ];
    description = "Jack audio server";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      LimitRTPRIO = "infinity";
      LimitMEMLOCK = "infinity";
      Environment="JACK_NO_AUDIO_RESERVATION=1";
      ExecStart = "${pkg-s.jack2}/bin/jackd -P71 -p1024 -dalsa -dhw:3 -r44100 -n2";
      User = "admin";
      Group = "audio";
      KillSignal="SIGKILL";
      Restart="always";
      # ExecStartPre="${pkg-s.pulseaudio}/bin/pulseaudio -k";
    };
  };
}
