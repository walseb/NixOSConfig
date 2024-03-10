{ pkg-s, pkgs-u, nixos-version, ... }:
{
  home.stateVersion = nixos-version;
  home.username = "admin";

  # programs.home-manager.enable = true;

  imports = [
    # ./modules-home/battery.nix
    ./nixos-private-config/private-home.nix
    ./modules-home/nix.nix
    # ./modules-home/caches.nix
    ./modules-home/notifications/dunst.nix
    ./modules-home/git.nix
    ./modules-home/gpg.nix
    ./modules-home/visual.nix
    ./modules-home/audio.nix

    ./modules-home/theme.nix

    ./modules-home/firefox.nix

    ./modules-home/cached-nix-shell.nix
    # ./modules-home/direnv/lorri.nix
    ./modules-home/direnv/nix-direnv.nix

    ./modules-home/ssh.nix

    ./modules-home/mpv.nix
    ./modules-home/mpris.nix

    ./modules-home/spell.nix

    ./modules-home/man.nix
    ./modules-home/redshift.nix

    # ./modules-home/dictionary/scowl.nix

    # ./modules-home/tools/activitywatch-stable.nix
    # Doesn't work with eshell currently
    # ./modules-home/comma.nix
  ];

  programs.bash.enable = true;

  # caches.cachix = (import ./modules-home/cachix-caches.nix);
  xdg.configFile."mimeapps.list".force = true;

  xdg.mimeApps = {
    enable = true;
  };

  # services.clipmenu.enable = true;

  home.packages = with pkg-s; [
    rclone
    xorg.xwininfo

    zip
    # (import ./modules-home/nyxt.nix {pkgs = pkgs;})
    # xfce.xfce4-notifyd
    # mpd
    # mpc_cli
    git-annex
    git
    # git-lfs

    # nix-top

    pavucontrol

    lm_sensors

    ripgrep

    atool
    unzip
    # TODO Find replacement
    # p7zip

    # Only works in main nixos config
    # mu

    gimp
    # redshift

    w3m

    chromedriver

    # shellcheck

    # cmake libtool gnumake

    # haskellPackages.structured-haskell-mode
    pinentry-emacs
    # libvterm

    # haskellPackages.glance - not on hackage
    # haskellPackages.visualize-cbn - marked as broken

    cloc

    imagemagick
    ghostscript

    # languagetool # jre

    # Required by the wordnut package
    # wordnet

    # Needed by cabal?
    binutils

    # Haskell
    # haskell.compiler.ghc882 # cabal-install
    # cabal-install

    hlint
    haskellPackages.hoogle

    haskellPackages.hp2pretty # haskellPackages.threadscope # haskellPackages.eventlog2html

    # haskellPackages.retrie

    # Haskell formatters
    # ormolu
    haskellPackages.fourmolu
    # haskellPackages.hindent
    # haskellPackages.brittany
    stylish-haskell

    nixfmt

    update-nix-fetchgit
    # (import ./modules-home/remarkable.nix)

    # (import ./modules-home/tools/FAS-3.nix)
    # dpkg-deb
    # nix-prefetch
    # nix-prefetch-git
    # nix-prefetch-github

    # Used by hlint-refactor-mode
    # haskellPackages.apply-refact

    # Broken
    # haskellPackages.halive

    # haskellPackages.ghc-imported-from
    # Applications

    # next

    # cachix

    # iosevka

    # ultimate-oldschool-pc-font-pack

    # unscii

    pwgen

    # tree-sitter
    # unstable.haskellPackages.tree-sitter-haskell

    # xdotool
    # xclip
    # haskellPackages.threadscope

    # ogre

    # (import ./modules-home/tools/youtube-music-desktop.nix)

    # (import ./modules-home/tools/ogre-2.nix)

    # nyxt

    # recoll

    # Needed by emacsqlite to compile binary
    # gcc

    # d2
    graphviz

    # Needed by gtk-launch
    gtk3

    # Emacs webkit
    # gcc pkg-config gtk3 webkitgtk glib-networking wrapGAppsHook
    # gdb
    # gnumake

    # gimp

    # gnuplot

    # dwarf-fortress

    anki

    # Needed to build the grammarly language server
    # nodejs

    # haskell-language-server

    # kdenlive

    # Dictionary browser, needed for package lexic
    sdcv

    # CLI media controls
    cabal-install
    ghc

    feh

    # qutebrowser
    # nyxt

    comma

    usbutils
    # gnuplot

    libqalculate

    inkscape

    # Screenshots
    maim

    # OCR
    tesseract5

    # misc
    ffmpeg
    audacity

    xcolor

    clipnotify
    xsel
    xclip

    file

    cbqn

    pkgs-u.plover.dev
    # (pkgs-u.plover.dev.overrideAttrs (orig: {
    #   version = "2.4.0";
    #   propagatedBuildInputs = with python3Packages; [ babel pyqt5 xlib pyserial appdirs wcwidth setuptools pip];

    #   src = pkgs.fetchFromGitHub {
    #     # https://github.com/openstenoproject/plover
    #     owner = "openstenoproject";
    #     repo = "plover";
    #     rev = "53c416fd893d62ab9ede5898129da3be856e910d";
    #     sha256 = "sha256-4MXETUhWxaO4lUX2fJ7CmfFvqC1P61Gq7523kD7oD6o=";
    #   };
    # }))
  ];
}
