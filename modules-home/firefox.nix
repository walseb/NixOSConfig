{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    # Default here sets the default profile in emacs
    profiles.default.settings = {
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "general.smoothScroll" = false;
    };

    # extensions = with pkgs.nur.repos.rycee.firefox-addons;
    #   [
    #     https-everywhere
    #   ];
  };
  # nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

}
