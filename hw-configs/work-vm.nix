{ pkgs, ... }:
{
  imports = [
    ./vbox-vm.nix
  ];

  environment.systemPackages = with pkgs; [
    mongodb
    redis
    gradle
    jdk11
  ];
}
