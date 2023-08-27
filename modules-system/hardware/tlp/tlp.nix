# https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/acpi_call.nix
# acpi_call makes tlp work for newer thinkpads
{ config, ... }:
{
  services.tlp.enable = true;

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };
}
