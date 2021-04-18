{ pkgs, file, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
  };

  services.xserver.desktopManager.surf-display = {
    enable = true;
    defaultWwwUri = file;
    inactivityInterval = 100;
  };
}
