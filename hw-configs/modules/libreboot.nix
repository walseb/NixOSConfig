{ config, pkgs, ... }:
{
  boot.loader.grub.copyKernels = true;

  hardware = {
    # enableAllFirmware = true;
    enableRedistributableFirmware = false;
    cpu = {
      amd.updateMicrocode = false;
      intel.updateMicrocode = false;
    };
  };
}
