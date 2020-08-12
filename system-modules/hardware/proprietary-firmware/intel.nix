{ config, pkgs, ... }:
{
  imports = [ ./redistributable-firmware.nix ];

  hardware.cpu.intel.updateMicrocode = true;
}
