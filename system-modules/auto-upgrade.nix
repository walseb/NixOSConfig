{
  system.autoUpgrade = {
    enable = true;
    flags = [ "--upgrade" ];

    dates = "03:00";
    randomizedDelaySec = "45min";
  };
}
