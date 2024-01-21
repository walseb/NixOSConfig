{ config, pkgs, ... }:
{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/libraries/aspell/dictionaries.nix

  home.file.".emacs.d/.aspell.en.pws".source = /etc/nixos/nixos-private-config/spell/.dict.en;
  home.file.".emacs.d/.aspell.sv.pws".source = /etc/nixos/nixos-private-config/spell/.dict.sv;

  home.packages = with pkgs; [
    aspell

    aspellDicts.en
    # Aspell has to be a sub-set of the hunspell library I have
    # aspellDicts.en-computers
    # aspellDicts.en-science
    aspellDicts.sv
  ];
}
