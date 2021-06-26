{ pkgs, ...}:
{
  programs.dconf.enable = true;

  # [[file:/etc/nixos/home-modules/audio.nix][See home manager for package]]
  # environment.systemPackages = with pkgs; [
  #   pulseeffects-pw
  # at-spi2-core
  # ];

    # systemd.services.pulseeffects-pipewire = {
  #   enable = true;
  #   description = "Pulseeffects";
  #   serviceConfig = {
  #     User = "admin";
  #     Group = "users";
  #     ExecStart = "${pkgs.pulseeffects-pw}/bin/pulseeffects --gapplication-service";
  #     Environment="DISPLAY=:0\n;NO_AT_BRIDGE=1";

  #     Restart = "on-failure";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "multi-user.target" ];
  # };
}
