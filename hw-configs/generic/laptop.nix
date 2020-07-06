{ pkgs, ... }:

{
  imports = [
    ../../modules/hardware/SSD.nix
    ../../modules/carpalx-layout.nix
  ];

  services.tlp.enable = true;

  # Hibernate after 1 hour of sleep
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
}
