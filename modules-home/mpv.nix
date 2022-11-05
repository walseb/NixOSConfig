{pkgs, ...}:
{
  home.packages = with pkgs; [
    (pkgs.mpv-with-scripts.override {
      scripts = [ pkgs.mpvScripts.mpris ];
    })
  ];

  # programs.mpv.scripts = [ pkgs.mpvScripts.mpris ];
}
