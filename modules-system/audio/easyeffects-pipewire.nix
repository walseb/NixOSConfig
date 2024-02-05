# The pulse effects daemon is enabled in home manager
{ pkg-s, ...}:
{
  # Needed for easyeffects to work
  programs.dconf.enable = true;

  # No longer avaliable?
  # services.easyeffects.enable = true;

  # [[file:/etc/nixos/modules-home/audio.nix][See home manager for package]]
  environment.systemPackages = with pkg-s; [
    # pulseeffects-pw
    easyeffects
    # at-spi2-core
  ];

  # systemd.services.pulseeffects-pipewire = {
  #   enable = true;
  #   description = "Pulseeffects";
  #   serviceConfig = {
  #     User = "admin";
  #     Group = "users";
  #     ExecStart = "${pkg-s.pulseeffects-pw}/bin/pulseeffects --gapplication-service";
  #     Environment="DISPLAY=:0\n;NO_AT_BRIDGE=1";

  #     Restart = "on-failure";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "multi-user.target" ];
  # };
}
