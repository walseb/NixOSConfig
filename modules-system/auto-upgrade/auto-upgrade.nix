{inputs, ...}:
{
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    allowReboot = true;
    flags = [
      "--update-input"
      "nixpkgs"

      "--update-input"
      "home-manager"

      "--update-input"
      "flake-utils"

      "-L" # print build logs
    ];

    # flags = [ "--upgrade" ];

    dates = "03:00";
    randomizedDelaySec = "45min";
  };

  # nix.gc = {
  #   automatic = true;
  #   dates = "07:00";
  #   options = "-d";
  # };
}
