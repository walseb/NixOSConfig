{ pkgs, ... }:
{
  services.redshift = {
    enable = true;
    provider = "manual";

    longitude = "0";
    latitude = "0";

    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";

    temperature.day = 3500;
    temperature.night = 3500;

    settings = 
      {
        redshift = {
          adjustment-method = "randr";
          brightness-day=1;
          brightness-night=1;

          # brightness-day=0.7;
          # brightness-night=0.7;
          # brightness-transition=50;
          gamma = 1;
          fade = 0;
        };
        randr = {
          screen = 0;
        };
      };
  };
}
