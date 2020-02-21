{ pkgs, ... }:

{
  imports = [
    ../cachix.nix
    ./vbox-vm.nix
  ];

  environment.systemPackages = with pkgs; [
    wakatime
    texlive.combined.scheme-full
    cachix
    krita
  ];
}
