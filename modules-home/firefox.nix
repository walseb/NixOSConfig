{ pkgs, ... }:

let firefoxSettings = 
      {
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "toolkit.tabbox.switchByScrolling" = true;
          "general.smoothScroll" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # Hide close button on tabs except current tab
          "browser.tabs.tabClipWidth" = 100000;
          # Start download in tmp dir
          "browser.download.start_downloads_in_tmp_dir" = true;

          "media.videocontrols.picture-in-picture.enabled" = false;

          "media.ffmpeg.vaapi.enabled" = true;
          "media.ffvpx.enabled" = false;
          "media.av1.enabled" = false;
          "gfx.webrender.all" = true;
      };

    userChromeSettings = ''
                  # Hide close buttons on tabs all together
                  .tabbrowser-tab .tab-close-button {
                    visibility: collapse !important;
                  }
                  # .titlebar-spacer {
                  #   display: none !important;
                  # }



                '';
    userContentSettings = ''
                 # Here too
                '';
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
in
{
  home.packages = with pkgs; [
    libdrm
  ];

  # https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuration
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  # home.sessionVariables = {
  #   MOZ_X11_EGL = "1";
  #   LIBVA_DRIVER_NAME = "$MY_LIBVA_DRIVER_NAME";
  #   # LIBVA_DRIVER_NAME = "i965";
  # };

  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };

  programs.firefox = {
    enable = true;

    extensions = with nur.repos.rycee.firefox-addons; [
      plasma-integration
      profile-switcher
      languagetool
      # skip-silence # https://addons.mozilla.org/en-US/firefox/addon/skip-silence/
      # color-by-fardos-color-picker # https://addons.mozilla.org/en-US/firefox/addon/color-by-fardos-color-picker
      # copy-all-tabs # https://addons.mozilla.org/en-US/firefox/addon/copy-all-tabs/
    ];

    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        EnableTrackingProtection = {
          Value = false;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        # ExtensionSettings = {};
        # CaptivePortal = false;
        # DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        # DisableFirefoxAccounts = false;
        # NoDefaultBookmarks = true;
        # OfferToSaveLogins = false;
        # OfferToSaveLoginsDefault = false;
        # PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          # Snippets = false;
          # TopSites = false;
          # Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };

    profiles = {
      default = {
        id = 0;
        name = "default";
        settings = firefoxSettings;
        userChrome = userChromeSettings;
        userContent = userContentSettings;
      };

      monsterAcademy = {
        id = 1;
        name = "Monster Academy";
        settings = firefoxSettings;
        userChrome = userChromeSettings;
        userContent = userContentSettings;
      };
    };
  };
  home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkgs.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";
}
