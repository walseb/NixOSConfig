{ config, pkgs, ... }:

# # Unstable packages
let
  unstable = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz")
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in {
  home.stateVersion = "20.03";

  programs.home-manager.enable = true;

  nixpkgs.config = {
    # allowBroken = true;
    # allowUnfree = false;
  };

  # Emacs overlay
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  imports = [
    ./home-device.nix
    ./home-modules/caches.nix
    ./home-modules/notifications.nix
    ./home-modules/git.nix
    ./home-modules/gpg.nix
    ./home-modules/visual.nix

    ./home-modules/cached-nix-shell.nix
    ./home-modules/direnv/direnv.nix
    ./home-modules/direnv/lorri.nix
  ];

  caches.cachix = (import ./cachix-caches.nix);

  home.packages = with pkgs; [
    # xfce.xfce4-notifyd
    # mpd
    # mpc_cli
    git
    git-lfs

    nix-top

    gnupg

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

    #emacs
    # emacsGit
    emacsGcc
    emacs-all-the-icons-fonts

    # haskellPackages.glance - not on hackage
    # haskellPackages.visualize-cbn - marked as broken

    cloc

    imagemagick

    aspell
    aspellDicts.en # aspellDicts.sv # languagetool # jre

    mpv

    # Needed by cabal?
    binutils

    # Haskell
    # haskell.compiler.ghc882 # cabal-install
    cabal-install

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
    # (import ./home-modules/fonts/scientifica.nix)
    # (import ./home-modules/fonts/BlockZone.nix)

    # ultimate-oldschool-pc-font-pack

    # unscii

    (import ./home-modules/fonts/my-inconsolata-lgc.nix)
    # inconsolata-lgc
    # inconsolata

    pwgen

    # tree-sitter
    # unstable.haskellPackages.tree-sitter-haskell

    xdotool
    xclip
    unstable.haskellPackages.threadscope
    # unstable.haskellPackages.eventlog2html
  ];
}
