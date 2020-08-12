{ config, pkgs, ... }:
{
  imports = [ ./redistributable-firmware.nix ];

  hardware.cpu.amd.updateMicrocode = true;
}
