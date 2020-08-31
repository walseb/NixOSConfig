{ pkgs, ... }:

{
  imports = [
    # ../cachix.nix
    ./generic/virtualbox.nix
    ./generic/pc.nix
  ];

  environment.systemPackages = with pkgs; [
    wakatime
    # texlive.combined.scheme-full
    # cachix
    krita
  ];
}
