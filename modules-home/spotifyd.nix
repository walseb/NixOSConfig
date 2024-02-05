{ config, pkg-s, ... }:

let
  unstable = import
    (builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  # imports = [
  #   ./build-spotifyd.nix
  # ];
  # services.spotifyd.package = pkg-s.spotifyd-git;
  services.spotifyd.package = (unstable.spotifyd.override { withMpris = true; withPulseAudio = true; });

  services.spotifyd.enable = true;
  services.spotifyd.package = pkg-s.spotifyd;
}
