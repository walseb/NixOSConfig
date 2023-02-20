{ config, pkgs, ... }:
{
  #   home.file."aspell-scowl.alias".text = ''
  # add .nix-profile/lib/aspell/en_US.multi
  #   '';

  home.packages = with pkgs; [
    (import ./aspell-dict.nix)
    scowl
  ];
}
