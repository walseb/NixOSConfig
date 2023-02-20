{ pkgs, ... }:

{
  home.stateVersion = "22.11";
  home.username = "admin";
  home.homeDirectory= "/home/admin";

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  imports = [
    ./home-device.nix
    # ./modules-home/caches.nix
    ./modules-home/notifications.nix
    ./modules-home/git.nix
    ./modules-home/gpg.nix
    ./modules-home/visual.nix
    ./modules-home/audio.nix

    ./modules-home/cached-nix-shell.nix
    ./modules-home/direnv/direnv.nix
    # ./modules-home/direnv/lorri.nix
    ./modules-home/direnv/nix-direnv.nix

    ./modules-home/ssh.nix

    ./modules-home/mpv.nix
    ./modules-home/mpris.nix
    ./modules-home/dictionary/spell.nix
    # ./modules-home/dictionary/scowl.nix

    # ./modules-home/tools/activitywatch-stable.nix
    # Doesn't work with eshell currently
    # ./modules-home/comma.nix
  ];

  # caches.cachix = (import ./modules-home/cachix-caches.nix);

  home.packages = with pkgs; [
    # xfce.xfce4-notifyd
    # mpd
    # mpc_cli
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

    aspell

    # shellcheck

    # cmake libtool gnumake

    # haskellPackages.structured-haskell-mode
    pinentry_emacs
    # libvterm

    # haskellPackages.glance - not on hackage
    # haskellPackages.visualize-cbn - marked as broken

    cloc

    imagemagick

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

    graphviz

    # Needed by gtk-launch
    gtk3

    # Emacs webkit
    # gcc pkg-config gtk3 webkitgtk glib-networking wrapGAppsHook
    # gdb
    # gnumake

    # gimp

    languagetool
    # Needed to call langtool jar
    # adoptopenjdk-jre-bin

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
  ];
}
