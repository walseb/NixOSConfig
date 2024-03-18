{ pkg-s, pkgs-u, nixos-version, ... }:
{
  home.stateVersion = nixos-version;
  home.username = "admin";

  imports = [
    ./modules-home/git.nix
    ./nixos-private-config/private-home.nix
  ];

  programs.bash.enable = true;
}
