# https://hydra.nix-community.org/project/emacs-overlay
# https://hydra.nix-community.org/jobset/emacs-overlay/unstable
# { pkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz" ) {}, ... }:
# with import <nixpkgs> {};

{ pkgs, ... }:
let
  emacsPkgsOverlay = import ./emacs/emacs-pkgs-overlay.nix { pkgs = pkgs; };
  emacsMainOverlay = import ./emacs/emacs-main-overlay.nix { pkgs = pkgs; };
  emacs29Overlay = import ./emacs/emacs-29-overlay.nix { pkgs = pkgs; };
  emacsNixpkgs = a: import
    (
      # builtins.fetchGit {
      #   name = "nixpkgs-emacs";
      #   url = "https://github.com/nixos/nixpkgs/";
      #   rev = "635a306fc8ede2e34cb3dd0d6d0a5d49362150ed"; # refs/heads/nixpkgs-unstable
      # }
      # <nixpkgs>
      # This fetches nixpgks unstable.
      pkgs.fetchFromGitHub {
        owner = "nixos";
        repo = "nixpkgs";
        rev = "ea780f3de2d169f982564128804841500e85e373"; # refs/heads/nixpkgs-unstable
        sha256 = "18arqzwv00mwaps98rgmnxcksgr4rm1ivmzfpjfkpkbbndid3h3b"; # refs/heads/nixpkgs-unstable
      }

    ) { overlays = [ (import a) ]; };

  nixpkgsEmacsPkgs = emacsNixpkgs emacsPkgsOverlay;

  nixpkgsEmacsMain = emacsNixpkgs emacsMainOverlay;

  nixpkgsEmacs29 = emacsNixpkgs emacs29Overlay;

  my-emacs29 = (nixpkgsEmacs29.emacsGit.overrideAttrs (old: {
    name = "emacs-29";
    version = "unstable-2024-01-14";

    # Emacs 29. Doesn't build due to new patches in emacs overlay. Fix later.
    src = pkgs.fetchFromGitHub {
      owner = "emacs-mirror";
      repo = "emacs";
      sha256 = "1fg845k530xb8hh1k1yjmypavi1lfdlvsrvc4acaxkfkh9bw08j7";
      # sha256 = "06j9m57wc8b4qh9hbkv3ndd2vhikp7dkqnvc2gdjl6146iix349p";
      rev = "5bb5590dec95e813ed120b3f09734451b4ebb18f"; # refs/heads/emacs-29

      # sha256 = "MhmLMXdd45hE2CEsOzI00LozoDvHOopRVB5fN3UbRyY=";
      # rev = "dc33a122230adbfa37926f4eb19c0620b3affd85";
    };
  }));

  # overrideAttrs
  gtkEmacs = nixpkgsEmacsMain.emacs-git.override {
    # withGTK2 = true;
    withGTK3 = true;
  };

in {
  imports = [ ./emacs/pkgs.nix ./emacs/frozen-pkgs.nix ];

  #home.packages = with nixpkgsEmacs29.emacsPackages; [
  home.packages = with nixpkgsEmacsPkgs.emacsPackages; [
    mlscroll
    jsonian

    # https://github.com/mitch-kyle/exwm/tree/master

    org-sticky-header

    daemons

    which-key
    # emacs
    gtkEmacs

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs/default.nix
    # pkgs.emacs29
    # emacs

    # recursion-indicator

    # scroll-on-drag

    bluetooth

    pkgs.libwebsockets
    ibrowse
    biome

    ivy-clipmenu

    pkgs.jansson
    pkgs.rnix-lsp

    pcmpl-args

    osm

    disk-usage

    # Change to this later if emacs-29 is released
     #nixpkgsEmacs29.emacs

    # emacsGitNativeComp
    # emacsNativeComp
    # emacsUnstable
    # emacs-all-the-icons-fonts
    # emacsUnstable

    bqn-mode
    leetcode

    litable

    bind

    ox-twbs

    # echo-bar

    dwim-shell-command

    notmuch-maildir

    jit-lock-stealth-progress

    friendly-shell
    friendly-shell-command

    # HTTP library
    plz

    orglink

    # org-assistant

    jinx

    # better-jumper

    stem-reading-mode

    vlf

    pcre2el

    org-roam
    # Org roam deps for emacs 29
    pkgs.sqlite
    emacsql-sqlite-builtin

    xr

    flyspell-correct

    exwm-firefox-evil
    exwm-firefox-core

    # This is broken on unstable
    # shm
    swiper
    flycheck-languagetool
    org-contrib
    ol-notmuch
    ellocate
    syntree
    vterm
    pdf-tools
    # Doesn't work
    #elpaDevelPackages.org

    #nixpkgsEmacsPkgs.cask
    cask
    elsa

    # elpaDevelPackages.org.overrideAttrs (attrs: {
    #   src = (fetchFromSavannah {
    #     owner = "emacs";
    #     repo = "org-mode";
    #     rev = "7b3b7b92e784c86c4ada1150d6e17a510b5ea3d0";
    #     sha256 = "097a327mp76nhd9y6sykbm5gq9qyx1n8v2ak6pz4pb76c4bb4gpx";
    #     });
    # })


    dash
    s
    ov
    exec-path-from-shell
    evil

    evil-goggles
    goggles


    evil-indent-plus
    # evil-textobj-anyblock
    evil-commentary
    evil-surround
    evil-lion
    titlecase
    # Using this fork for now https://github.com/mitch-kyle/exwm/tree/master
    # exwm
    exwm-edit
    hydra
    xterm-color
    su
    async
    command-log-mode
    drag-stuff
    org-ml
    org-modern
    # org-superstar
    org-anki
    org-appear
    doct
    org-super-agenda
    org-ql
    ob-async
    org-noter
    outline-minor-faces
    outshine
    vertico
    # selectrum
    marginalia
    consult
    consult-flycheck
    embark
    embark-consult
    ivy
    wgrep
    counsel
    ivy-rich
    company
    flycheck
    flycheck-package
    yasnippet
    consult-yasnippet
    isearch-mb
    jump-tree
    avy
    avy-flycheck
    dired-rsync
    dired-atool
    dired-du
    realgud
    ivy-xref
    quick-peek
    dumb-jump
    graphviz-dot-mode
    lsp-mode
    lsp-ui
    lsp-ui
    sly
    pair-tree
    suggest
    elisp-format
    cider
    # lsp-java
    haskell-mode
    company-cabal
    lsp-haskell
    dante
    # ccls
    markdown-mode
    # web-mode
    dap-mode
    gnuplot
    lispy
    pinentry
    espy
    # with-editor
    envrc
    nix-mode
    company-nixos-options
    w3m
    projectile
    magit
    htmlize
    notmuch
    journalctl-mode
    google-translate
    lexic
    macro-math
    blimp
    # indent-guide
    adaptive-wrap
    olivetti
    rainbow-mode
    symbol-overlay
    yascroll
    hl-todo
    font-lock-profiler
    git-backup
    git-backup-ivy
    undo-tree
    vundo
    undo-fu
    compat
  ];
}
