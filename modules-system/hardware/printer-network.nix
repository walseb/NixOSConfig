{ pkg-s, ... }:
{
  imports = [
    ./printer.nix
  ];

  services.avahi.nssmdns = true;
  services.avahi.enable = true;
}
