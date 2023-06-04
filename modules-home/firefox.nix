{ pkgs, lib, ... }:

# For all options, see
# https://github.com/mozilla/gecko-dev/blob/master/modules/libpref/init/all.js
# https://github.com/mozilla/gecko-dev/blob/master/browser/app/profile/firefox.js
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

        # "media.videocontrols.picture-in-picture.enabled" = false;

        # Must be true for exwm clipboard transfer to work
        "clipboard.autocopy" = true;

        # GPU rendering
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;
        "media.av1.enabled" = false;
        "gfx.webrender.all" = true;

        # Force enable hardware decoding
        "media.hardware-video-decoding.force-enabled" = true;

        # Only click after mouseup.
        "ui.context_menus.after_mouseup" = true;
        # Disable spell check
        "layout.spellcheckDefault" = 0;

        # # Unmap backspace in navigation mode
        "browser.backspace_action" = 2;

        # Disable middle click based navigation
        "middlemouse.contentLoadURL" = false;
        "middlemouse.paste" = false;

        # Disable default mpris implementation. Replaced by plasma browser integration
        "media.hardwaremediakeys.enabled" = false;

        # Disable kinetic scroll
        "apz.gtk.kinetic_scroll.enabled" = false;

        # Don't auto-open downloads panel
        "browser.download.alwaysOpenPanel" = false;

        # # Disable quit shortcut?
        # "browser.quitShortcut.disabled" = true;

        # Disable fullscreen warning
        "full-screen-api.warning.timeout" = 0;

        # Compact layout
        "browser.uidensity" = 1;

        "browser.tabs.loadBookmarksInTabs" = true;

        # browser.tabs.insertAfterCurrent
        # browser.urlbar.openintab
        # browser.tabs.unloadOnLowMemory

        # Search bar
        "accessibility.typeaheadfind.enablesound" = false;
        "findbar.matchdiacritics" = 2;
        "findbar.highlightAll" = true;

        # ?
        # "browser.chrome.toolbar_tips" = false;

        # Disable the bar that pops up when you press alt
        "ui.key.menuAccessKeyFocuses" = false;

        # Don't close window when last tab has been closed
        "browser.tabs.closeWindowWithLastTab" = false;

        # "browser.chrome.disableRemoteControlCueForTests" = true;

        # Defines the protocols that will be active for the Remote Agent.
        # 1: WebDriver BiDi
        # 2: CDP (Chrome DevTools Protocol)
        # 3: WebDriver BiDi + CDP
        # remote.active-protocols =

        # Enable WebDriver BiDi experimental commands and events.
        # remote.experimental.enabled


        # Defines the verbosity of the internal logger.
        #
        # Available levels are, in descending order of severity, "Trace", "Debug",
        # "Config", "Info", "Warn", "Error", and "Fatal". The value is treated
        # case-sensitively.
        # "remote.log.level" = "Info"
        "remote.log.level" = "Error";


        # Certain log messages that are known to be long are truncated. This
        # preference causes them to not be truncated.
        # pref("remote.log.truncate", true);


        # Sets recommended automation preferences when Remote Agent or Marionette is started.
        # pref("remote.prefs.recommended", true);

        # Disable gesture to go back and forward in history
        "browser.gesture.swipe.left" = "cmd_scrollLeft";
        "browser.gesture.swipe.right" = "cmd_scrollRight";
      };

    monsterAcademySettings = lib.mkMerge [firefoxSettings {"marionette.port" = 36289; }]; # MARIONETTE PORT: Monster Academy
    defaultSettings = lib.mkMerge [firefoxSettings {"marionette.port" = 36288; }]; # MARIONETTE PORT: default
    alenSettings = lib.mkMerge [firefoxSettings {"marionette.port" = 36287; }]; # MARIONETTE PORT: Alen

    # defaultSettings = {
    #   inherit firefoxSettings;
    #   # "marionette.port" = 36288;
    # };

    userJs = ''
# Object.defineProperty(navigator, 'webdriver', {get: () => false})
 '';

    userChromeSettings = ''
# Hide close buttons on tabs all together
# .tabbrowser-tab .tab-close-button {
# visibility: collapse !important;
# }
# .titlebar-spacer {
#   display: none !important;
# }

# Hide close button
# Doesn't work
# .titlebar-buttonbox-container{ display:none  !important;  }

# # Hide button icons
# .button-box .button-icon {
# display: none;
# }
# Font
# * {
#     font-family: "FONT_NAME";
# }

/* Tab bar */
# .tabbrowser-strip *[class^="scrollbutton"] {
#     /* Hide tab scroll buttons */
#     display: none;
# }

# .tabbrowser-strip *[class^="tabs-alltabs"] {
#     /* Hide tab drop-down list */
#     display: none;
# }

# .tabbrowser-strip *[class^="tabs-newtab-button"] {
#     /* Hide new-tab button */
#     display: none;
# }
                '';
    userContentSettings = ''
# Doesn't work
# .titlebar-buttonbox-container { display: none !important; }
                 # Here too
                '';
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
    myBookmarks =
      [
        {
          name = "Task Manager";
          keyword = "mail";
          url = "about:performance";
        }
        {
          name = "mail.com";
          keyword = "mail";
          url = "mail.com";
        }
      ];

    myFirefoxUnwrapped = (pkgs.firefox-unwrapped.overrideAttrs (old: {
      # patches = pkgs.firefox-unwrapped.patches ++ [
      #   ./firefox/marionette.patch
      # ];
    }));
in
{
  home.packages = with pkgs; [
    libdrm
    # gnomeExtensions.gsconnect
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


  # patches = nixpkgsPatches ++ [
  #   ./firefox.patch
  # ];

  programs.firefox = {
    enable = true;

    extensions = with nur.repos.rycee.firefox-addons; [
      plasma-integration
      # gsconnect

      # profile-switcher
      languagetool

      # linkhints # https://addons.mozilla.org/en-US/firefox/addon/linkhints

      # window-titler # https://addons.mozilla.org/en-GB/firefox/addon/window-titler/
      # github-repo-size # https://github.com/Shywim/github-repo-size
      # unload-tabs # https://addons.mozilla.org/en-US/firefox/addon/unload-tabs/

      # bard-for-search-engines # https://addons.mozilla.org/en-US/firefox/addon/bard-for-search-engines/
      # simple-translate # https://addons.mozilla.org/en-US/firefox/addon/simple-translate/
      # download-notify # https://addons.mozilla.org/en-US/firefox/addon/download-notify/
      # pixel-perfect-pro # https://addons.mozilla.org/en-US/firefox/addon/pixel-perfect-pro/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search
      # copy-selected-tabs-to-clipboar # https://addons.mozilla.org/en-US/firefox/addon/copy-selected-tabs-to-clipboar/
      # copy-all-tabs # https://addons.mozilla.org/en-US/firefox/addon/copy-all-tabs/
      # skip-silence # https://addons.mozilla.org/en-US/firefox/addon/skip-silence/
    ];

    package = pkgs.wrapFirefox myFirefoxUnwrapped
      {
        cfg.enablePlasmaBrowserIntegration = true;
        # cfg.gsconnect = true;

        # See https://github.com/mozilla/policy-templates
        extraPolicies = {
          Homepage = {
            Locked = true;
            StartPage = "previous-session";
          };

          StartDownloadsInTempDirectory = true;

          UseSystemPrintDialog = false;

          PictureInPicture = {
            Enabled = false;
            Locked = true;
          };
          EnableTrackingProtection = {
            Value = false;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
            Cookies = false;
            TrackingContent = false;
          };
          # ExtensionSettings = {};
          # CaptivePortal = false;
          # DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          # DisableFirefoxAccounts = false;
          NoDefaultBookmarks = true;
          # OfferToSaveLogins = false;
          # OfferToSaveLoginsDefault = false;
          # PasswordManagerEnabled = false;
          DisplayBookmarksToolbar = "newtab";
          OfferToSaveLogins = true;

          browser.newtabpage.enabled = true;
          FirefoxHome = {
            Search = true;
            TopSites = false;
            Highlights = false;
            Pocket = false;
            SponsoredPocket = false;
            SponsoredTopSites = false;
            Snippets = false;
            Locked = true;
          };

          # https://github.com/mozilla/policy-templates#usermessaging
          UserMessaging = {
            WhatsNew = true;
            ExtensionRecommendations = true;
            FeatureRecommendations = true;
            UrlbarInterventions = true;
            SkipOnboarding = true;
            MoreFromMozilla = true;

          };
        };
      };

    profiles = {
      default = {
        id = 0;
        name = "default"; # FIREFOX USER -- Used by elisp. Don't insert any quotes here
        # settings = firefoxSettings;
        settings = defaultSettings;
        userChrome = userChromeSettings;
        userContent = userContentSettings;
        bookmarks = myBookmarks;
        extraConfig = userJs;
      };

      monsterAcademy = {
        id = 1;
        name = "Monster Academy"; # FIREFOX USER -- Used by elisp. Don't insert any quotes here
        # settings = firefoxSettings;
        settings = monsterAcademySettings;
        userChrome = userChromeSettings;
        userContent = userContentSettings;
        bookmarks = myBookmarks;
        extraConfig = userJs;
      };

      alen = {
        id = 2;
        name = "Alen"; # FIREFOX USER -- Used by elisp. Don't insert any quotes here
        # settings = firefoxSettings;
        settings = alenSettings;
        userChrome = userChromeSettings;
        userContent = userContentSettings;
        bookmarks = myBookmarks;
        extraConfig = userJs;
      };
    };
  };

  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.firefox.override {
  #     cfg.enablePlasmaBrowserIntegration = true;
  #   };
  # }
  # home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkgs.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";
}
