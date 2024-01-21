{ config, ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
