# https://hydra.nix-community.org/project/emacs-overlay
# https://hydra.nix-community.org/jobset/emacs-overlay/unstable
# { pkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz" ) {}, ... }:
# with import <nixpkgs> {};

{ ... }:
let
  new-pkgs =
    # import (fetchTarball "https://github.com/rycee/home-manager/archive/release-22.11.tar.gz")
    import (builtins.fetchGit {
      name = "nixpkgs-emacs";
      url = "https://github.com/nixos/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      # WARNING: update-nix-fetchgit updates this to the latest master
      rev = "37b97ae3dd714de9a17923d004a2c5b5543dfa6d";
      # ref = "refs/heads/nixos-22.11";
      # rev = "e285dd0ca97c264003867c7329f0d1f4f028739c";
    })
      {
        overlays = [
          (import (builtins.fetchTarball {
            url =
              # "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
              "https://github.com/nix-community/emacs-overlay/archive/fc341b52fe5837ef313cfe79eea7e2a05b6efffa.tar.gz";
            # "https://github.com/nix-community/emacs-overlay/archive/b14b8b133d98c923071ec2e20eff3c76bd80d173.tar.gz";
          }))
        ];
      };
in
{
  imports = [
    ./emacs/pkgs.nix
    ./emacs/frozen-pkgs.nix
  ];

  home.packages = with new-pkgs; with new-pkgs.emacsPackages; [
    # Emacs pinned at version 29
    (emacsGit.overrideAttrs
      (old : {
        name = "emacs-29";
        version = "unstable-2023-01-13";
        src = fetchFromGitHub {
          repo = "emacs";
          owner = "emacs-mirror";
          sha256 = "MhmLMXdd45hE2CEsOzI00LozoDvHOopRVB5fN3UbRyY=";
          rev = "dc33a122230adbfa37926f4eb19c0620b3affd85";
        };
      }))

    # emacsGitNativeComp
    # emacsNativeComp
    # emacsUnstable
    # emacs-all-the-icons-fonts
    # emacsUnstable

    stem-reading-mode

    org-roam
    # Org roam deps for emacs 29
    pkgs.sqlite
    emacsql-sqlite-builtin

    xr

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
    selectrum
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
    with-editor
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
    flyspell-correct
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
