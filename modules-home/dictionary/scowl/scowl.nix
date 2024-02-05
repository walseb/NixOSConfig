{ config, pkg-s, ... }:
{
  #   home.file."aspell-scowl.alias".text = ''
  # add .nix-profile/lib/aspell/en_US.multi
  #   '';

  home.packages = with pkg-s; [
    (import ./aspell-dict.nix)
    scowl
  ];
}
