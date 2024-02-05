{pgks, ...}:
# Ideas for showing diff and such
# https://discourse.nixos.org/t/how-to-get-this-pending-updates-notification-in-gnome/16344/5
# https://blog.tjll.net/previewing-nixos-system-updates/

{
  systemd.services.nixos-upgrade = {
    description = "NixOS Upgrade";

    restartIfChanged = false;
    unitConfig.X-StopOnRemoval = false;

    serviceConfig.Type = "oneshot";

    environment = config.nix.envVars // {
      inherit (config.environment.sessionVariables) NIX_PATH;
      HOME = "/root";
    } // config.networking.proxy.envVars;

    path = with pkgs; [
      coreutils
      gnutar
      xz.bin
      gzip
      gitMinimal
      config.nix.package.out
      config.programs.ssh.package
    ];

    script = let
      nixos-rebuild = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild";
      date     = "${pkgs.coreutils}/bin/date";
      readlink = "${pkgs.coreutils}/bin/readlink";
      shutdown = "${config.systemd.package}/bin/shutdown";
      upgradeFlag = optional (cfg.channel == null) "--upgrade";
    in if cfg.allowReboot then ''
        ${nixos-rebuild} boot ${toString (cfg.flags ++ upgradeFlag)}
        booted="$(${readlink} /run/booted-system/{initrd,kernel,kernel-modules})"
        built="$(${readlink} /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

        ${optionalString (cfg.rebootWindow != null) ''
          current_time="$(${date} +%H:%M)"

          lower="${cfg.rebootWindow.lower}"
          upper="${cfg.rebootWindow.upper}"

          if [[ "''${lower}" < "''${upper}" ]]; then
            if [[ "''${current_time}" > "''${lower}" ]] && \
               [[ "''${current_time}" < "''${upper}" ]]; then
              do_reboot="true"
            else
              do_reboot="false"
            fi
          else
            # lower > upper, so we are crossing midnight (e.g. lower=23h, upper=6h)
            # we want to reboot if cur > 23h or cur < 6h
            if [[ "''${current_time}" < "''${upper}" ]] || \
               [[ "''${current_time}" > "''${lower}" ]]; then
              do_reboot="true"
            else
              do_reboot="false"
            fi
          fi
        ''}

        if [ "''${booted}" = "''${built}" ]; then
          ${nixos-rebuild} ${cfg.operation} ${toString cfg.flags}
        ${optionalString (cfg.rebootWindow != null) ''
          elif [ "''${do_reboot}" != true ]; then
            echo "Outside of configured reboot window, skipping."
        ''}
        else
          ${shutdown} -r +1
        fi
      '' else ''
        ${nixos-rebuild} ${cfg.operation} ${toString (cfg.flags ++ upgradeFlag)}
      '';

    startAt = cfg.dates;

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  systemd.timers.nixos-upgrade = {
    timerConfig = {
      RandomizedDelaySec = cfg.randomizedDelaySec;
      FixedRandomDelay = cfg.fixedRandomDelay;
      Persistent = cfg.persistent;
    };
  };
}
