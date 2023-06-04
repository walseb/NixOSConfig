# https://hydra.nix-community.org/project/emacs-overlay
# https://hydra.nix-community.org/jobset/emacs-overlay/unstable
# { pkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz" ) {}, ... }:
# with import <nixpkgs> {};

{ pkgs, ... }:
let
  emacsPkgsOverlay = import ./emacs/emacs-pkgs-overlay.nix { pkgs = pkgs; };
  emacsMainOverlay = import ./emacs/emacs-main-overlay.nix { pkgs = pkgs; };
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
        rev = "635a306fc8ede2e34cb3dd0d6d0a5d49362150ed"; # refs/heads/nixpkgs-unstable
        sha256 = "V2p/A4RpEGqEZussOnHYMU6XglxBJGCODdzoyvcwig8="; # refs/heads/nixpkgs-unstable
      }
    ) { overlays = [ (import a) ]; };

  nixpkgsEmacsPkgs = emacsNixpkgs emacsPkgsOverlay;

  nixpkgsEmacsMain = emacsNixpkgs emacsMainOverlay;
in {
  imports = [ ./emacs/pkgs.nix ./emacs/frozen-pkgs.nix ];

  home.packages = with nixpkgsEmacsPkgs.emacsPackages; [
    # Make sure to build emacs using normal nixpkgs so that we don't need to rebuild it every time the emacs overlay gets updated
    (nixpkgsEmacsMain.emacsGit.overrideAttrs (old: {
      name = "emacs-29";
      version = "unstable-2023-05-13";

      src = pkgs.fetchFromGitHub {
        owner = "emacs-mirror";
        repo = "emacs";
        sha256 = "1dsi8pq314ch2wbqhr02qqvk95fyvl0mc2vy5fffyp8k7iy20dwp";
        # sha256 = "06j9m57wc8b4qh9hbkv3ndd2vhikp7dkqnvc2gdjl6146iix349p";
        rev = "1e6a7594361fa4d60c0d73450e45475593d93696"; # refs/heads/emacs-29

        # sha256 = "MhmLMXdd45hE2CEsOzI00LozoDvHOopRVB5fN3UbRyY=";
        # rev = "dc33a122230adbfa37926f4eb19c0620b3affd85";
      };
    }))

    # emacsGitNativeComp
    # emacsNativeComp
    # emacsUnstable
    # emacs-all-the-icons-fonts
    # emacsUnstable

    bind

    ox-twbs

    dwim-shell-command

    friendly-shell
    friendly-shell-command

    # HTTP library
    plz

    orglink

    # org-assistant

    jinx

    better-jumper

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
    org
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
    org
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
    ccls
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
    indent-guide
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
  ];
}
