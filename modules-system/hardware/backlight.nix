{ pkg-s, ... }:

{
  hardware.acpilight.enable = true;

  environment.systemPackages = with pkg-s; [
    acpilight
  ];
}
