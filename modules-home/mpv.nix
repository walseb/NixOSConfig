{pkgs, ...}:
{
  home.packages = with pkgs; [
    (pkgs.mpv.override {
      scripts = [ pkgs.mpvScripts.mpris ];
    })
  ];

  # programs.mpv.scripts = [ pkgs.mpvScripts.mpris ];
}
