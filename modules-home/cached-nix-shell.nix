{ pkg-s, ... }:
{
  home.packages = with pkg-s; [ cached-nix-shell ];
  programs.bash.shellAliases = { nix-shell = "cached-nix-shell"; };
}
