{ pkg-s, lib, callPackage, ... }:

{
  imports = [
    ../home.nix

    ../nixos-private-config/email.nix
    # ./modules-home/games/cataclysm-dda/cataclysm-dda-git-latest.nix
    # ./modules-home/art.nix
    # ./modules-home/hie.nix
    # ./modules-home/spotify.nix
    # ./modules-home/spotifyd.nix
    .././modules-home/emacs.nix

    # (import ./modules-system/inkscape/inkscape-silhouette.nix {lib= lib; python3Packages = pkgs.python3Packages; fetchFromGitHub = pkgs.fetchFromGitHub; wrapQtAppsHook = pkgs.wrapQtAppsHook; cups = lib.cups; })
  ];
  # programs.git = {
  #   signing = {
  #     key = "";
  #     signByDefault = true;
  #   };
  # };
  # home.packages = with pkg-s; [ obs-studio ];

  home.packages = with pkg-s; [
    # (import ./pkgs/laser-etching/ezgraver.nix)

    # (import ./my-inconsolata-lgc.nix)

    # inkscape-with-extensions

    # (import ./modules-system/inkscape/inkscape-extensions-proxy.nix {lib = lib; inkscape = pkgs.inkscape; symlinkJoin = symlinkJoin; makeWrapper = makeWrapper; inkscapeExtensions = [(pkgs.callPackage ./modules-system/inkscape/inkscape-silhouette.nix {lib= lib; python3Packages = pkgs.python3Packages; fetchFromGitHub = pkgs.fetchFromGitHub; cups = lib.cups; })]; inkscape-extensions = null;})

    # (import ./modules-home/tools/FAS-3.nix)

    # openxcom

    # These are for inkscape silhouette
    # libusb
    # libusb1
    # python39Packages.enamlx
    # python39Packages.twisted
    # python39Packages.lxml
    # python39Packages.qreactor
    # python39Packages.jsonpickle
    # python39Packages.pyserial
    # python39Packages.pycups
    # python39Packages.libusb1
    # python39Packages.inkex
    # python39Packages.pyusb
    # pkgs.libusb-compat-0_1
#    freeciv

 #   nxengine-evo
  ];

  # services.spotifyd.settings = {
  #   global = {
  #     username = "";
  #     # The actual account password, not an api key or anything
  #     password = "";
  #     # Can't contain spaces
  #     device_name = "";

  #     backend = "pulseaudio";
  #   };
  # };
}
