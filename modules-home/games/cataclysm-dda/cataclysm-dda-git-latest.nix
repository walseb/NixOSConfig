{ pkg-s, ... }:
{
  imports = [
    ./cataclysm-dda-git-latest-override.nix
  ];

  home.packages = with pkg-s; [
    cataclysm-dda-git-master
  ];
}
