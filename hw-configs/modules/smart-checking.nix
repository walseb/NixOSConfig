{ config, pkgs, ... }:
{
  # SMART checking
  smartd = {
    enable = true;
    devices = [{ device = "/dev/sda"; }];
    notifications.test = true;
    notifications.x11.enable = true;
  };
  fstrim.enable = true;
}
