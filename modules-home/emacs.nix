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

      pkgs.fetchFromGitHub {
        owner = "nixos";
        repo = "nixpkgs";
        rev = "af8cd5ded7735ca1df1a1174864daab75feeb64a"; # refs/heads/nixpkgs-unstable
        sha256 = "0a81s3n25l2rk86gp2yxpnxv8a33cknml8z2snfzcsjp0g1a0xr3"; # refs/heads/nixpkgs-unstable
      }
    ) { overlays = [ (import a) ]; };

  nixpkgsEmacsPkgs = emacsNixpkgs emacsPkgsOverlay;

  nixpkgsEmacsMain = emacsNixpkgs emacsMainOverlay;

  nixpkgsEmacs29 = emacsNixpkgs emacs29Overlay;

  emacs29 = (nixpkgsEmacs29.emacsGit.overrideAttrs (old: {
    name = "emacs-29";
    version = "unstable-2023-07-24";

    # Emacs 29. Doesn't build due to new patches in emacs overlay. Fix later.
    src = pkgs.fetchFromGitHub {
      owner = "emacs-mirror";
      repo = "emacs";
      sha256 = "1jmyx89nz5klpk1xwdhx3zd39f4p99a6mdmqyd2dylfnyw0j2q0n";
      # sha256 = "06j9m57wc8b4qh9hbkv3ndd2vhikp7dkqnvc2gdjl6146iix349p";
      rev = "c2d95dd00e6cb0abaf4e7550f38c8c2c9ca22f2d"; # refs/heads/emacs-29

      # sha256 = "MhmLMXdd45hE2CEsOzI00LozoDvHOopRVB5fN3UbRyY=";
      # rev = "dc33a122230adbfa37926f4eb19c0620b3affd85";
    };
  }));
in {
  imports = [ ./emacs/pkgs.nix ./emacs/frozen-pkgs.nix ];

  home.packages = with nixpkgsEmacsPkgs.emacsPackages; [
    ivy-clipmenu

    pkgs.jansson
    pkgs.rnix-lsp

    # Make sure to build emacs using normal nixpkgs so that we don't need to rebuild it every time the emacs overlay gets updated
    nixpkgsEmacsMain.emacs-git
    # emacs29
    # emacs

    pcmpl-args

    osm

    disk-usage

    # Change to this later if emacs-29 is released
    # nixpkgsEmacs29.emacs

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

    echo-bar

    dwim-shell-command

    notmuch-maildir

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

    # flyspell-correct

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
    elpaDevelPackages.org

    nixpkgsEmacsPkgs.cask
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
    evil-indent-plus
    # evil-textobj-anyblock
    evil-commentary
    evil-surround
    evil-lion
    titlecase
    exwm
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
    web-mode
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
