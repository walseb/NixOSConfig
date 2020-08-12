{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  # services.lorri.enable = true;
}
