{ pkgs, ... }:

{
  imports = [
    ../../system-modules/hardware/SSD.nix
    ../../system-modules/carpalx-layout.nix
  ];

  services.tlp.enable = true;

  # Hibernate after 1 hour of sleep
  # systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  # Only turn off screen on lid close
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
}
