{ pkgs, pkg-s-path, pkg-s, lib, ... }:

{
  imports = [
    ../generic/lumos-server.nix
    (import ../../modules-system/nix.nix {inherit pkgs; inherit pkg-s-path; inherit pkg-s; inherit lib; max-jobs = 2;})

    ../../modules-system/file-server/http-file-server.nix

    ./hardware-configuration.nix


    ../../modules-system/hardware/tlp/tlp-intel-powersave.nix

    ../../modules-system/hardware/proprietary-firmware/intel.nix


    ../../modules-system/boot/uefi.nix
    ../../modules-system/hardware/SSD.nix
    ../../modules-system/network/sshd.nix
  ];
}
