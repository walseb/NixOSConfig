{
  system.autoUpgrade = {
    allowReboot = true;
    enable = true;
    flags = [ "--upgrade" ];

    dates = "03:00";
  };

  nix.gc = {
    automatic = true;
    dates = "07:00";
    options = "-d";
  };
}
