{ pkgs, ... }: {
  services.pulseeffects.enable = true;
  services.pulseeffects.package = pkgs.pulseeffects-pw;
  # services.pulseeffects.preset = "default";
}
