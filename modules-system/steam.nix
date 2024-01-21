{ pkgs, stdenv, lib, fetchurl, ...}:
{
  environment.systemPackages = with pkgs; [
    steam-run-native
    # (import ./steam/steam-ge.nix)
  ];

  programs.steam.enable = true;

  # programs.steam.remotePlay.openFirewall = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  environment.variables.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "${./steam/steam-ge.nix}";

  # nixpkgs.config.packageOverrides = pkgs: {
  #   steam = pkgs.steam.override {
  #     nativeOnly = true;
  #   };
  # };
}
