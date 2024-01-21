{ pkgs, ... }:
{
  home.packages = with pkgs; [ cached-nix-shell ];
  programs.bash.shellAliases = { nix-shell = "cached-nix-shell"; };
}
