{
  system.autoUpgrade = {
    enable = true;
    # flags = [ "--upgrade" ];

    system.autoUpgrade.operation = "switch";
    dates = "03:00";
    randomizedDelaySec = "45min";
    persistent = true;
  };
}
