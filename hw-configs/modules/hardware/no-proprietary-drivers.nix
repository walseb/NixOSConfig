{ config, pkgs, ... }:
{
  hardware = {
    # enableAllFirmware = true;
    enableRedistributableFirmware = false;
    cpu = {
      amd.updateMicrocode = false;
      intel.updateMicrocode = false;
    };
  };
}
