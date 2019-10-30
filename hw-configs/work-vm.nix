{ pkgs, ... }:
{
  imports = [
    ./home-vm.nix
  ];

  environment.systemPackages = with pkgs; [
    mongodb
    redis
  ];
}
