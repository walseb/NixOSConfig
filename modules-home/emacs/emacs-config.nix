{ pkg-s, emacs-overlay, emacs }:
with pkg-s;

stdenv.mkDerivation rec {
  pname = "Emacs config";
  version = "master";

  propagatedBuildInputs = with emacs-overlay.emacsPackages; [
    haskell-emacs

    # filechooser
    mlscroll
    jsonian

    # https://github.com/mitch-kyle/exwm/tree/master

    crdt

    org-sticky-header

    daemons

    which-key
    # emacs

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs/default.nix
    # pkg-s.emacs29
    # emacs

    # recursion-indicator

    # scroll-on-drag

    bluetooth

    pkg-s.libwebsockets
    ibrowse
    biome

    ivy-clipmenu

    pkg-s.jansson
    # pkg-s.rnix-lsp
    pkg-s.nil

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

    mini-frame

    stem-reading-mode

    vlf

    pcre2el

    org-roam
    # Org roam deps for emacs 29
    pkg-s.sqlite
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

  dontUnpack = true;

  src = ../../cfg/emacs;
  # Shell script: 
  # emacs --dump-file="/Users/yuan/.emacs.d/emacs.pdmp"

  installPhase = ''
    ${emacs} --batch --eval '(progn (load \"~/.emacs.d/early-init.el\") (load \"~/.emacs.d/init.el\") (message \"-EMACS BUILT SUCCESSFULLY-\"))'
    '';
}
