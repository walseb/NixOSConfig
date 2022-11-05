{ pkgs, ... }:

{
  hardware.acpilight.enable = true;

  environment.systemPackages = with pkgs; [
    acpilight
  ];
}
