{ ... }:
{
  imports = [
    ./geoclue2.nix
  ];

  services.redshift = {
    # brightness.day =
    # brightness.night =
    enable = true;
    temperature = {
      day = 3000;
      night = 3000;
    };
  };
}
