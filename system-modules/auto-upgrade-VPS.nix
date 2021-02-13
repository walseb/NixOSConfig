{
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flags = [ "--upgrade" ];

    dates = "03:00";
    randomizedDelaySec = "45min";
  };

  nix.gc = {
    automatic = true;
    dates = "07:00";
    options = "-d";
  };
}
