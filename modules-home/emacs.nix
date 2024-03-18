# https://hydra.nix-community.org/project/emacs-overlay
# https://hydra.nix-community.org/jobset/emacs-overlay/unstable
# { pkg-s ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz" ) {}, ... }:
# with import <nixpkgs> {};

{ pkg-s, config, emacs-overlay, ... }:
let
  # my-emacs29 = (emacs-overlay-emacs.emacsGit.overrideAttrs (old: {
  #   name = "emacs-29";
  #   version = "unstable-2024-01-14";

  #   # Emacs 29. Doesn't build due to new patches in emacs overlay. Fix later.
  #   src = pkg-s.fetchFromGitHub {
  #     owner = "emacs-mirror";
  #     repo = "emacs";
  #     sha256 = "1fg845k530xb8hh1k1yjmypavi1lfdlvsrvc4acaxkfkh9bw08j7";
  #     # sha256 = "06j9m57wc8b4qh9hbkv3ndd2vhikp7dkqnvc2gdjl6146iix349p";
  #     rev = "5bb5590dec95e813ed120b3f09734451b4ebb18f"; # refs/heads/emacs-29

  #     # sha256 = "MhmLMXdd45hE2CEsOzI00LozoDvHOopRVB5fN3UbRyY=";
  #     # rev = "dc33a122230adbfa37926f4eb19c0620b3affd85";
  #   };
  # }));

  # overrideAttrs
  gtkEmacs = emacs-overlay.emacs-git.overrideAttrs {
    # gtkEmacs = emacs-overlay.emacs-pgtk.overrideAttrs {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs/make-emacs.nix
    # withGTK2 = true;
    withGTK3 = true;
    # withPgtk = true;

    patches = emacs-overlay.emacs-git.patches ++ [ ./emacs/transparency.patch ];
  };

in {
  imports = [ ./emacs/pkgs.nix ./emacs/frozen-pkgs.nix ];

  # services.emacs = {
  #   enable = true;
  #   package = gtkEmacs;
  #   defaultEditor = true;
  #   startWithUserSession = true;
  #   extraOptions = ["--debug-init"];
  # };

  # systemd.user.services.emacs = {
  #   # restartIfChanged = false;
  #   # Prevent emacs from being restarted by updates
  #   Unit = {
  #     X-SwitchMethod = "keep-old";
  #   };
  #   Service.Restart = lib.mkForce "never";
  # };

  home.sessionVariables = {
    # This option is necessary for firefox to use the portal
    GTK_USE_PORTAL = "1";

    MOZ_X11_EGL = "1";
    MOZ_USE_XINPUT2 = "1";

    PAGER = "cat";
    VISUAL = "emacsclient -r";
    EDITOR = "emacsclient -r";

    # XDG_DESKTOP_PORTAL_DIR = "${emacs-overlay.emacsPackages.filechooser}";
  };

  # systemd.user.services = {
  #   emacs-ac = {
  #     Unit = {
  #       Description = "Notify emacs on ac";
  #       PartOf = [ "ac.target" ];
  #     };
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = ''
  #         ${gtkEmacs}/bin/emacsclient -e "(run-hooks #'my/bat-ac-hook)"'';
  #     };

  #     Install = {
  #       WantedBy = [ "ac.target" ];
  #     };
  #   };

  #   emacs-battery = {
  #     Unit = {
  #       Description = "Notify emacs on battery";
  #       PartOf = [ "battery.target" ];
  #     };
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = ''
  #         ${gtkEmacs}/bin/emacsclient -e "(run-hooks #'my/bat-battery-hook)"'';
  #     };
  #     Install = {
  #       WantedBy = [ "battery.target" ];
  #     };
  #   };
  # };

  # Link Emacs config
  home.file.".emacs.d/".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/deps/emacs;

  # replace with emacs-gtk, or a version provided by the community overlay if desired.
  #home.packages = with nixpkgsEmacs29.emacsPackages; [
  home.packages = with emacs-overlay.emacsPackages; [
    midi-kbd

    consult-notmuch
    consult-hoogle

    magit-annex

    saveplace-pdf-view

    consult-dir

    el-patch
    pkg-s.gh
    consult-gh

    # PROBLEM: Nix isn't able to build this, as my config reaches for ~/.nix-profile
    # (import ./emacs/emacs-config.nix {inherit pkg-s; inherit emacs-overlay; emacs = gtkEmacs;})

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
    gtkEmacs

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs/default.nix
    # pkg-s.emacs29
    # emacs

    # recursion-indicator

    # scroll-on-drag

    bluetooth

    pkg-s.libwebsockets
    # ibrowse requires the websocket library
    websocket
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
