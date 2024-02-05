{ config, ... }:
{
  imports = [
    ./spell/aspell.nix
    ./spell/nuspell.nix

    ./enchant.nix
    # ./languagetool.nix
  ];
}
