# * Config
{ pkgs, ... }:
{
  imports = [
    # ./modules-home/email.nix
    # ./modules-home/games/cataclysm-dda/cataclysm-dda-git-latest.nix
    # ./modules-home/emacs.nix
    # ./modules-home/art.nix
    # ./modules-home/spotify.nix
    # ./modules-home/spotifyd.nix
    # ./modules-home/email.nix
  ];

  # home.packages = with pkgs; [

  # ];

  # ** Git
  # programs.git = {
  #   signing = {
  #     key = "";
  #     signByDefault = true;
  #   };
  # };

  # ** Email
  # accounts.email = {
  #   accounts.main-gmail = {
  #     passwordCommand = "echo gmail-app-password";
  #   };
  # };

  # ** Spotifyd
  # services.spotifyd.settings =
  #   {
  #     global = {
  #       username = "";
  #       # The actual account password, not an api key or anything
  #       password = "";
  #       # Can't contain spaces
  #       device_name = "";

  #       backend = "pulseaudio";
  #     };
  #   };
}
