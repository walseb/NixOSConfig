{ config, pkgs, ... }:
{

  imports = [
    ./enchant.nix
    ./languagetool.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/libraries/aspell/dictionaries.nix

  home.packages = with pkgs; [
    aspell

    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.sv
  ];
}
