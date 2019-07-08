{ config, pkgs, ... }:
{
  boot.kernelParams = [ "nomodeset" ];
}
