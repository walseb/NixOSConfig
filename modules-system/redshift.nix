{ ... }:
{
  imports = [
    # ./location/geoclue2.nix
    ./location/fake-location.nix
  ];

  services.redshift = {
    # brightness.day =
    # brightness.night =
    # extraOptions = ["-l" "0:0"];
    enable = true;
    temperature = {
      day = 3500;
      night = 3500;
    };
  };
}
