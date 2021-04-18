{ pkgs, ... }:
{
  # Go to http://localhost:631/ to configure
  services.printing.enable = true;
  services.printing.drivers = [ # pkgs.gutenprint
    pkgs.hplip ];
}
