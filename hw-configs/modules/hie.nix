{ pkgs, ... }:
let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  imports = [
    ./games/cataclysm-dda/cataclysm-dda-git-latest.nix
  ];

  environment.systemPackages = with pkgs; [
    # Install HIE for ghc864
    (all-hies.selection { selector = p: { inherit (p) /* ghc863 */ ghc864; }; })
  ];
}
