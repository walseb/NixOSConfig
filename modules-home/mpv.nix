{pkg-s, ...}:
{
  home.packages = with pkg-s; [
    (pkg-s.mpv.override {
      scripts = [ pkg-s.mpvScripts.mpris ];
    })
  ];

  programs.mpv.config = {
    hwdec="auto-safe";
    vo="gpu";
    profile="gpu-hq";
  };
  # hardware acceleration
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  # hwdec=auto-safe
  #   vo=gpu
  #     profile=gpu-hq

  # programs.mpv.scripts = [ pkg-s.mpvScripts.mpris ];
}
