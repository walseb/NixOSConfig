{pkgs, ...}:
{
  home.packages = with pkgs; [
    (pkgs.mpv.override {
      scripts = [ pkgs.mpvScripts.mpris ];
    })
  ];

  # hardware acceleration
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  # hwdec=auto-safe
  #   vo=gpu
  #     profile=gpu-hq

  # programs.mpv.scripts = [ pkgs.mpvScripts.mpris ];
}
