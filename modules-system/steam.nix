{ pkgs, pkg-s, stdenv, lib, fetchurl, inputs, ...}:
{
  environment.systemPackages = with pkg-s; [
    # steam-run-native

    # steam
    # (import ./steam/steam-ge.nix)
    # This allows for steam to install normal games
    steam-run-native
  ];

  programs.steam = {
    # enable steam as usual
    enable = true;
    package = pkg-s.steam;


    # add extra compatibility tools to your STEAM_EXTRA_COMPAT_TOOLS_PATHS using the newly added `extraCompatPackages` option
    extraCompatPackages = [
      # add the packages that you would like to have in Steam's extra compatibility packages list
      # pkgs.luxtorpeda
      inputs.nix-gaming.packages.${pkg-s.system}.proton-ge
      # etc.
    ];
  };

  # programs.steam.package = pkg-s.steam;
  # programs.steam.enable = true;

  # programs.steam.remotePlay.openFirewall = true;

  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "steam"
  #   "steam-run"
  #   "steam-original"
  #   "steam-runtime"
  # ];


  # environment.variables.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
  #   "${(import ./steam/steam-ge.nix)}";

  # nixpkgs.config.packageOverrides = pkg-s: {
  #   steam = pkg-s.steam.override {
  #     nativeOnly = true;
  #   };
  # };
}
