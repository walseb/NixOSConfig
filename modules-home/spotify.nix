{ pkg-s, ... }:

{
  home.packages = with pkg-s; [
    spotify
  ];
}
