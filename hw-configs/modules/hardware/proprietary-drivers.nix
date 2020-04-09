{ config, pkgs, ... }:
{
  hardware = {
    # enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu = {
      amd.updateMicrocode = true;
      intel.updateMicrocode = true;
    };
  };
}
