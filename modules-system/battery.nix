{
  # From here:
  # https://github.com/bbigras/nix-config
  systemd.targets = {
    ac = {
      description = "On AC power";
      unitConfig.DefaultDependencies = false;
    };
    battery = {
      description = "On battery power";
      unitConfig.DefaultDependencies = false;
    };
  };

  services = {
    udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="0", RUN+="${config.systemd.package}/bin/systemctl start battery.target"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="0", RUN+="${config.systemd.package}/bin/systemctl stop ac.target"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1", RUN+="${config.systemd.package}/bin/systemctl start ac.target"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1", RUN+="${config.systemd.package}/bin/systemctl stop battery.target"

      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="0", RUN+="${config.systemd.package}/bin/systemctl --user --machine=bbigras@.host start battery.target"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="0", RUN+="${config.systemd.package}/bin/systemctl --user --machine=bbigras@.host stop ac.target"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1", RUN+="${config.systemd.package}/bin/systemctl --user --machine=bbigras@.host start ac.target"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1", RUN+="${config.systemd.package}/bin/systemctl --user --machine=bbigras@.host stop battery.target"
    '';
  };

  systemd.timers = {
    btrbk-home.partOf = [ "ac.target" ];
    btrbk-home.wantedBy = [ "ac.target" ];
    logrotate.partOf = [ "ac.target" ];
    logrotate.wantedBy = [ "ac.target" ];
    systemd-tmpfiles-clean.partOf = [ "ac.target" ];
    systemd-tmpfiles-clean.wantedBy = [ "ac.target" ];
    fstrim.partOf = [ "ac.target" ];
    fstrim.wantedBy = [ "ac.target" ];
  };
}

