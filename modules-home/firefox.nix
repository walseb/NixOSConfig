{ pkgs, config, lib, ... }:

# For all options, see
# https://github.com/mozilla/gecko-dev/blob/master/modules/libpref/init/all.js
# https://github.com/mozilla/gecko-dev/blob/master/browser/app/profile/firefox.js
# https://hg.mozilla.org/mozilla-central/file/tip/modules/libpref/init/StaticPrefList.yaml#l9652
let firefoxSettings =
      {
        # Portal
        # Each setting can have the following values:
        # 0 – Never
        #   1 – Always
        #   2 – Auto (typically depends on whether Firefox is run from within Flatpak or whether the GDK_DEBUG=portals environment is set)
        #   The settings are:
        # widget.use-xdg-desktop-portal.file-picker – Whether to use XDG portal for the file picker
        #   widget.use-xdg-desktop-portal.mime-handler – Whether to use XDG portal for the mime handler
        #   widget.use-xdg-desktop-portal.settings – Whether to try to use XDG portal for settings/look-and-feel information
        #   widget.use-xdg-desktop-portal.location – Whether to use XDG portal for geolocation
        #   widget.use-xdg-desktop-portal.open-uri – Whether to use XDG portal for opening to a file

        # Always open new window
        # "browser.link.open_newwindow" = 2;
        # "browser.link.open_newwindow.restriction" = 0;
        # "browser.link.open_newwindow.override.external" = 2;
        # "middlemouse.openNewWindow" = true;

        # Always open in tab
        "browser.link.open_newwindow" = 3;
        "browser.link.open_newwindow.restriction" = 0;
        "browser.link.open_newwindow.override.external" = 2;

        # Fully disable pocket
        "extensions.pocket.enabled" = true;

        # Disable border in firefox
        "browser.tabs.inTitlebar" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.tabbox.switchByScrolling" = true;
        "general.smoothScroll" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Hide close button on tabs except current tab
        "browser.tabs.tabClipWidth" = 100000;

        # http://kb.mozillazine.org/Browser.tabs.disableBackgroundClose
        # Hopefully make sure tabs can't be closed with the mouse
        "browser.tabs.disableBackgroundClose" = true;

        # Start download in tmp dir
        "browser.download.start_downloads_in_tmp_dir" = true;

        # https://support.mozilla.org/en-US/questions/1194305
        # Disable scroll to zoom
        "mousewheel.with_control.action" = 1;

        # "media.videocontrols.picture-in-picture.enabled" = false;

        # Don't save session periodically or resume from crash https://wiki.archlinux.org/title/Firefox/Tweaks#Longer_interval_between_session_information_record
        "browser.sessionstore.resume_from_crash" = false;

        # Must be true for exwm clipboard transfer to work
        "clipboard.autocopy" = true;

        "devtools.accessibility.enabled" = false; # removes un-needed "Inspect Accessibility Properties" on right-click

        # GPU rendering
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;

        # Firefox sometimes uses AV1 video decoding even to GPUs which do not support it.
        "media.av1.enabled" = false;

        "gfx.webrender.all" = true;

        # Enable the compositor
        "gfx.webrender.compositor" = true;
        "gfx.webrender.compositor.force-enabled" = true;

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

        # Make middle click start moving
        "general.autoScroll" = true;

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
        "browser.compactmode.show" = 1;

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

        # Stop strange tab focus behavior after closing a tab.  http://kb.mozillazine.org/Browser.tabs.selectOwnerOnClose
        "browser.tabs.selectOwnerOnClose" = false;

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

        # Disable firefox search shortcuts. Replaces strings such as @google in search bar.
        "browser.urlbar.suggest.engines" = false;

        # Remove delay from when audio is paused to when the audio icon disappears.
        "browser.tabs.delayHidingAudioPlayingIconMS" = 0;

        # Insert new tabs after current always
        "browser.tabs.insertAfterCurrent" = true;

        # Disable autoplay
        "media.autoplay.allow-extension-background-pages" = false;
        "media.autoplay.default" = 5;
        "media.autoplay.block-event.enabled" = true;
        "media.autoplay.block-webaudio" = true;
        "media.block-autoplay-until-in-foreground" = false;

        "ui.textHighlightBackground" = "#004a00";
        "ui.textHighlightForeground" = "#00b100";
        # ui.textSelectAttentionBackground
        # ui.textSelectAttentionForeground
        # ui.textSelectDisabledBackground

        "toolkit.scrollbox.smoothScroll" = false;

        # https://www.reddit.com/r/firefox/comments/wpynv7/how_do_i_disable_the_animation_when_i_close_a_tab/
        "ui.prefersReducedMotion" = 1;

        "permissions.default.shortcuts" = 2;

        # Unload tabs when memory is < 400mb
        # https://www.reddit.com/r/firefox/comments/co6xng/browsertabsunloadonlowmemory_how_much_is_low/
        "browser.tabs.unloadOnLowMemory" = "false";

        # determine how long (in ms) tabs are inactive before they unload
        # 60000=1min; 300000=5min; 600000=10min (default)
        "browser.tabs.min_inactive_duration_before_unload" = 6000000; # 100 min;

        # Don't need the screenshot functionality
        # "extensions.screenshots.disabled" = "true";

        # Enable screenshots
        "screenshots.browser.component.enabled" = true;

        # Don't save screenshot previews of pages
        "browser.pagethumbnails.capturing_disabled" = true;

        "browser.toolbars.bookmarks.visibility" = "newtab";
        # Always hid bookmarks. Having them shown causes an issue when switching tabs.
        # "browser.toolbars.bookmarks.visibility" = "never";

        # "browser.tabs.showAudioPlayingIcon" = false;


        # Experimental performance settings
        # See Betterfox
        "content.notify.interval" = 100000;

        "gfx.canvas.accelerated.cache-items" = 4096; # default=2048; alt=8192
        "gfx.canvas.accelerated.cache-size" = 512; # default=256; alt=1024
        "gfx.content.skia-font-cache-size" = 20; # default=5; Chrome=20

        "browser.cache.disk.enable" = true;
        "browser.cache.disk.smart_size.enabled" = false;
        "browser.cache.disk.capacity" = 1024000; # (1gb) Default: 256000
        "browser.cache.disk.metadata_memory_limit" = 500; # default=250 (0.25 MB); limit of recent metadata we keep in memory for faster access
        # "browser.cache.disk.preload_chunk_count" = 4; # default
        # "browser.cache.disk.preload_chunk_count" = 4; # default
        "browser.cache.frecency_half_life_hours" = 6; # default, 6 hours
        # Compress JS a bit
        "browser.cache.jsbc_compression_level" = 3;

        # https://kb.mozillazine.org/Browser.cache.memory.capacity#-1
        "browser.cache.memory.capacity" = 512000;
        "browser.cache.memory.max_entry_size" = 10240;
        # Store this many pages in ram https://kb.mozillazine.org/Browser.sessionhistory.max_total_viewers#Possible_values_and_their_effects
        "browser.sessionhistory.max_total_viewers" = 8;

        "media.cache_size" = 512000; # default
        "media.memory_cache_max_size" = 65536;
        # Don't limit based on resources available
        "media.memory_caches_combined_limit_pc_sysmem" = 100;


        # Video cache
        # "media.cache_readahead_limit" = 7200; # 120 min; default=60; stop reading ahead when our buffered data is this many seconds ahead of the current playback
        # "media.cache_resume_threshold" = 3600; # 60 min; default=30; when a network connection is suspended, don't resume it until the amount of buffered data falls below this threshold

        "image.cache.size" = 10485760; # (cache images up to 10MiB in size)
        "image.mem.decode_bytes_at_a_time" = 32768; # default=16384; alt=65536; chunk size for calls to the image decoders

        "network.buffer.cache.size" = 262144; # // 256 kb; default=32768 (32 kb)
        "network.buffer.cache.count" = 128; # // default=24

        "network.http.max-connections" = 1800; # default=900
        "network.http.max-persistent-connections-per-server" = 10; # default=6; download connections; anything above 10 is excessive
        "network.http.max-urgent-start-excessive-connections-per-host"= 5; # default=3

        # Pacing HTTP requests can have some benefits, such as reducing network congestion, improving web page loading speed, and avoiding server overload. Pacing requests adds a slight delay between requests to throttle them. If you have a fast machine and internet connection, disabling pacing may provide a small speed boost when loading pages with lots of requests.
        "network.http.pacing.requests.enabled" = false;

        # Increase DNS cache
        "network.dnsCacheEntries" = 1000; # default=400
        "network.dnsCacheExpiration" = 3600; # keep entries for 1 hour
        # the number of threads for DNS
        "network.dns.max_high_priority_threads" = 8; # default=5

        "network.ssl_tokens_cache_capacity" = 10240; # default=2048; more TLS token caching (fast reconnects)

        # Used for cross-origin connections to provide small performance improvements. Disable DNS prefetching to prevent Firefox from proactively resolving hostnames for other domains linked on a page. This may eliminate unnecessary DNS lookups, but can increase latency when following external links.
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = false;
        # preconnect to the autocomplete URL in the address bar Firefox preloads URLs that autocomplete when a user types into the address bar. Connects to destination server ahead of time, to avoid TCP handshake latency. [NOTE] Firefox will perform DNS lookup (if enabled) and TCP and TLS handshake, but will not start sending or receiving HTTP data.
        "browser.urlbar.speculativeConnect.enabled" = false;
        # mousedown speculative connections on bookmarks and history
        "browser.places.speculativeConnect.enabled" = false;
        # Pre-populates the HTTP cache by prefetching same-site future navigation resources or subresources used on those pages. Enabling link prefetching allows Firefox to preload pages tagged as important. The browser prefetches links with the prefetch-link tag, fetching resources likely needed for the next navigation at low priority. When clicking a link or loading a new page, prefetching stops and discards hints. Prefetching downloads resources without executing them. [NOTE] Since link prefetch uses the HTTP cache, it has a number of issues with document prefetches, such as being potentially blocked by Cache-Control headers (e.g. cache partitioning).
        "network.prefetch-next" = false;

        # Indicates whether the `fetchpriority` attribute for elements which support it.
        "network.fetchpriority.enabled" = true;

        # Network Predictor (NP)
        # When enabled, it trains and uses Firefox's algorithm to preload page resource by tracking past page resources. It uses a local file (history) of needed images, scripts, etc. to request them preemptively when navigating. [NOTE] By default, it only preconnects, doing DNS, TCP, and SSL handshakes. No data sends until clicking. With "network.predictor.enable-prefetch" enabled, it also performs prefetches.
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enable-hover-on-ssl" = false;

        # CSS Masonry Layout
        "layout.css.grid-template-masonry-value.enabled" = true;
        # Prioritized Task Scheduling API
        "dom.enable_web_task_scheduling" = true;
        # CSS :has() selector [NIGHTLY]
        "layout.css.has-selector.enabled" = true;
        # HTML Sanitizer API
        "dom.security.sanitizer.enabled" = true;

        # Zoom levels
        "toolkit.zoomManager.zoomValues" = ".1,.2,.3,.4,.5,.6,.7,.8,.9,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9.3,4,5";
        # Apply zoom only to current tab and not site-wide
        "browser.zoom.siteSpecific" = false;
        # Zoom.minPercent
        # Zoom.maxPercent

        "devtools.toolbox.zoomValue" = 1.2; # increases the default text size in Firefox devtools to 120%
        "devtools.inspector.showUserAgentStyles" = true; #shows user-agent styles in the CSS Rules pane in Firefox devtools (why are user-agent styles hidden by default?) 
        "browser.chrome.guess_favicon" = false; # stops Firefox from attempting to load the website’s favicon from the default location when an icon is <i>not</i> declared in the HTML document (I use this config to get rid of the distracting ”favicon not found” errors in the devtools console) 

        # Configure UI
        "ui.caretWidth" = 2;
        "ui.caretBlinkTime" = -1;

        # Simply start typing to do a search
        "accessibility.typeaheadfind" = true;

        # Don't prompt about notifications  
        "dom.webnotifications.enabled" = false;
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

    userChromeSettings = builtins.readFile ./firefox/userChrome.css;
    #     userContentSettings = ''
    # # Doesn't work
    # # .titlebar-buttonbox-container { display: none !important; }
    #                  # Here too
    #                 '';
    # nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    #   inherit pkgs;
    # };
    myBookmarks =
      [
        {
          name = "Google Bard";
          keyword = "bard";
          url = "https://bard.google.com/";
        }
        {
          name = "Task Manager";
          keyword = "tasks";
          url = "about:performance";
        }
        {
          name = "mail.com";
          keyword = "mail";
          url = "mail.com";
        }
      ];

    # Try this:
    # https://github.com/Athena-OS/athena-nix/blob/39162284fecf626d11990c122c277336d0f90d1e/nixos/home-manager/browsers/firefox/default.nix#L116
    myExtensions = with config.nur.repos.rycee.firefox-addons; [
      plasma-integration
      # gsconnect

      # profile-switcher
      languagetool

      # view-page-archive # https://addons.mozilla.org/en-US/firefox/addon/view-page-archive/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search
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
      # mute-sites-by-default https://addons.mozilla.org/en-US/firefox/addon/mute-sites-by-default/
    ];

    myFirefoxUnwrapped = (pkgs.firefox-unwrapped.overrideAttrs (old: {
      # Changes here require rebuilding of Firefox
      # allowAddonSideload = true;
      # browser.allowAddonSideload = true;
      # browser.requireSigning = false;
      # browser.pipewireSupport = true;


      # nativeMessagingHosts = [ pkgs.plasma-browser-integration ];
      # patches = pkgs.firefox-unwrapped.patches ++ [
      #   ./firefox/marionette.patch
      # ];
    }));
    # https://github.com/Athena-OS/athena-nix/blob/39162284fecf626d11990c122c277336d0f90d1e/nixos/home-manager/browsers/firefox/default.nix#L116
    search = {
      force = true;
      default = "Google";
      engines = {
        # "Nix Packages" = {
        #   urls = [{
        #     template = "https://search.nixos.org/packages";
        #     params = [
        #       { name = "type"; value = "packages"; }
        #       { name = "query"; value = "{searchTerms}"; }
        #     ];
        #   }];
        #   icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        #   definedAliases = [ "@np" ];
        # };
        # "NixOS Wiki" = {
        #   urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
        #   iconUpdateURL = "https://nixos.wiki/favicon.png";
        #   updateInterval = 24 * 60 * 60 * 1000;
        #   definedAliases = [ "@nw" ];
        # };
        "Wikipedia (en)".metaData.alias = "@wiki";
        "Google".metaData.hidden = true;
        "Amazon.com".metaData.hidden = true;
        "Bing".metaData.hidden = true;
        "eBay".metaData.hidden = true;
      };

    };
    in
      {

        xdg.mimeApps.defaultApplications = {
          "message/rfc822" = "firefox.desktop";
          "x-scheme-handler/mailto" = "firefox.desktop";
          "application/x-extension-htm" = "firefox.desktop";
          "application/x-extension-html" = "firefox.desktop";
          "application/x-extension-shtml" = "firefox.desktop";
          "application/x-extension-xht" = "firefox.desktop";
          "application/x-extension-xhtml" = "firefox.desktop";
          "application/xhtml+xml" = "firefox.desktop";
          "text/html" = "firefox.desktop";
          "x-scheme-handler/chrome" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
        };

        # config = {
        #   firefox = {
        #     allowAddonSideload = true;
        #     requireSigning = false;
        #     pipewireSupport = true;
        #   };
        # };


        home.packages = with pkgs; [
          libdrm
plasma-browser-integration
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

  # programs.firefox.nativeMessagingHosts.packages = [ pkgs.plasma-browser-integration ];

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/firefox.nix
  # https://github.com/NixOS/nixpkgs/tree/491072e797f6d28960f182d45125f1f93b9522ce/pkgs/applications/networking/browsers/firefox
  # https://github.com/NixOS/nixpkgs/blob/491072e797f6d28960f182d45125f1f93b9522ce/pkgs/applications/networking/browsers/firefox/wrapper.nix



  programs.firefox = {


    enable = true;

    # nativeMessagingHosts.packages = [ pkgs.plasma5Packages.plasma-browser-integration ];
    # nativeMessagingHosts.packages = [ pkgs.plasma-browser-integration];

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/browsers/firefox/wrapper.nix
    package = pkgs.wrapFirefox.override {
      # Here you can set packages to be used
    } myFirefoxUnwrapped
      {
        # allowAddonSideload = true;
        # requireSigning = true;
        # cfg.enablePlasmaBrowserIntegration = true;
        # cfg.gsconnect = true;
        # cfg.nativeMessagingHosts.packages = [ pkgs.plasma-browser-integration ];

        # cfg.browser.allowAddonSideload = true;
        # cfg.browser.requireSigning = true;
        # browser.requireSigning = false;
        # nixExtensions = [
        # https://ryantm.github.io/nixpkgs/builders/packages/firefox/
        # (pkgs.fetchFirefoxAddon {
        #   name = "h264ify"; # Has to be unique!
        #   url = "https://addons.mozilla.org/firefox/downloads/file/3398929/h264ify-1.1.0.xpi";
        #   sha256 = "87bd3c4ab1a2359c01a1d854d7db8428b44316fef5b2ac09e228c5318c57a515";
        # })
        # ];

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
        # userContent = userContentSettings;
        bookmarks = myBookmarks;
        extraConfig = userJs;
        extensions = myExtensions;
      };

      monsterAcademy = {
        id = 1;
        name = "Monster Academy"; # FIREFOX USER -- Used by elisp. Don't insert any quotes here
        # settings = firefoxSettings;
        settings = monsterAcademySettings;
        userChrome = userChromeSettings;
        # userContent = userContentSettings;
        bookmarks = myBookmarks;
        extraConfig = userJs;
        extensions = myExtensions;
      };

      alen = {
        id = 2;
        name = "Alen"; # FIREFOX USER -- Used by elisp. Don't insert any quotes here
        # settings = firefoxSettings;
        settings = alenSettings;
        userChrome = userChromeSettings;
        # userContent = userContentSettings;
        bookmarks = myBookmarks;
        extraConfig = userJs;
        extensions = myExtensions;
      };
    };
  };

  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.firefox.override {
  #     cfg.enablePlasmaBrowserIntegration = true;
  #   };
  # }

  # Seems like plasma is broken in newest home manager
  home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkgs.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";
}
