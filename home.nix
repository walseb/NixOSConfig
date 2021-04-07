{ config, pkgs, ... }:

{
  home.stateVersion = "20.03";

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowBroken = true;
    # allowUnfree = false;
  };

  imports = [
    ./home-device.nix
    # ./home-modules/caches.nix
    ./home-modules/notifications.nix
    ./home-modules/git.nix
    ./home-modules/gpg.nix
    ./home-modules/visual.nix

    ./home-modules/cached-nix-shell.nix
    ./home-modules/direnv/direnv.nix
    # ./home-modules/direnv/lorri.nix
    ./home-modules/direnv/nix-direnv.nix

    ./home-modules/ssh.nix

    # ./home-modules/tools/activitywatch-stable.nix
    # Doesn't work with eshell currently
    # ./home-modules/comma.nix

    ./home-modules/emacs.nix
  ];

  # caches.cachix = (import ./home-modules/cachix-caches.nix);

  home.packages = with pkgs; [
    # xfce.xfce4-notifyd
    # mpd
    # mpc_cli
    git
    git-lfs

    nix-top

    pavucontrol

    lm_sensors

    ripgrep

    atool
    unzip
    # TODO Find replacement
    # p7zip

    # mail
    isync
    msmtp
    # Only works in main nixos config
    # mu

    # gimp
    redshift

    w3m

    shellcheck

    # cmake libtool gnumake

    # haskellPackages.structured-haskell-mode
    pinentry_emacs
    # libvterm

    # haskellPackages.glance - not on hackage
    # haskellPackages.visualize-cbn - marked as broken

    cloc

    imagemagick

    aspell
    aspellDicts.en # aspellDicts.sv # languagetool # jre

    # Required by the wordnut package
    wordnet

    mpv

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
    ormolu
    # haskellPackages.hindent
    # haskellPackages.brittany
    stylish-haskell

    nixfmt

    nix-prefetch
    nix-prefetch-git
    nix-prefetch-github

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

    xdotool
    xclip
    # haskellPackages.threadscope
    # unstable.haskellPackages.eventlog2html

    # ogre

    # (import ./home-modules/tools/youtube-music-desktop.nix)

    # (import ./home-modules/tools/ogre-2.nix)

    nyxt

    graphviz

    recoll

    # Needed by emacsqlite to compile binary
    gcc

    graphviz

    # Needed by gtk-launch
    gnome3.gtk

    # Notmuch
    mailcap

    # Emacs webkit
    # gcc pkg-config gtk3 webkitgtk glib-networking wrapGAppsHook
    # gdb

    # Needed by org-roam
    sqlite
  ];
}
