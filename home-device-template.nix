# * Config
{ pkgs, ... }:
{
  imports = [
    # ./home-modules/email.nix
    # ./home-modules/games/cataclysm-dda/cataclysm-dda-git-latest.nix
    # ./home-modules/build-emacs.nix
    # ./home-modules/art.nix
    # ./home-modules/spotify.nix
    # ./home-modules/spotifyd.nix
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
