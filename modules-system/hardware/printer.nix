{ pkgs, ... }:
{
  # Go to http://localhost:631/ to configure
  services.printing.enable = true;
  services.printing.drivers = [ # pkgs.gutenprint
    # For [[id:82955db6-5f53-459e-9484-1b50c21ed06a][HP Deskjet 3720 -> file:~/Notes/20220828193319.org]]
    pkgs.hplip
    pkgs.epson-escpr
    # pkgs.epson-escpr2
  ];

  # services.printing.tempDir = "/tmp/cups";
}
