{ pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    steam-run-native
  ];

  programs.steam.enable = true;


  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];


  # nixpkgs.config.packageOverrides = pkgs: {
  #   steam = pkgs.steam.override {
  #     nativeOnly = true;
  #   };
  # };
}
