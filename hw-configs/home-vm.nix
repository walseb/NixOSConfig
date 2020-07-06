{ pkgs, ... }:

{
  imports = [
    # ../cachix.nix
    ./generic/virtualbox.nix
  ];

  environment.systemPackages = with pkgs; [
    wakatime
    # texlive.combined.scheme-full
    # cachix
    krita
  ];
}
