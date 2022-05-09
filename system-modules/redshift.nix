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
      day = 3500;
      night = 3500;
    };
  };
}
