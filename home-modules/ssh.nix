{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    controlMaster = "yes";
  };
}
