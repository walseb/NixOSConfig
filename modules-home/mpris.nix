{pkg-s, ...}:
{
  # services.playerctld.enable = true;
  home.packages = with pkg-s; [
    playerctl
  ];
}
