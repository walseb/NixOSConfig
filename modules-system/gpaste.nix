{ pkgs, ... }:
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      gpaste-1 = (pkgs.gnome.gpaste.override { }).overrideAttrs (old: rec {
        version = "master";

        src = pkgs.fetchFromGitHub {
          owner = "Keruspe";
          repo = "GPaste";
          rev = "c73181a58a12286c3107e4b3836926265d433ec7";
          sha256 = "sha256-JO19RTSHhMbN7ps57kllX88kzwTavM67wC4avNo1UiY=";
        };

        patches = [ ];
      });
    };
  };
}
