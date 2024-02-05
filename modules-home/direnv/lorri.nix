{ pkg-s, ... }:
{
  services.lorri.enable = true;
  services.lorri.package = pkg-s.lorri;
}
