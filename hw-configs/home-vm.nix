{ pkgs, ... }:

{
  imports = [
    ./vbox-vm.nix
  ];

  environment.systemPackages = with pkgs; [
    wakatime
  ];
}
