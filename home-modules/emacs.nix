# https://hydra.nix-community.org/project/emacs-overlay
# https://hydra.nix-community.org/jobset/emacs-overlay/unstable
# { pkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz" ) {}, ... }:
{config, pkgs, ... }:
{
  # Emacs overlay
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      # "https://github.com/nix-community/emacs-overlay/archive/d8288f606564792365790a305617913ad3be86a5.tar.gz";
      # "https://github.com/nix-community/emacs-overlay/archive/d8288f606564792365790a305617913ad3be86a5.tar.gz";
    }))
  ];

  home.packages = with pkgs; [
    # environment.systemPackages = with pkgs; [
    #emacs
    # emacsGit

    # emacsGcc
    # emacs-all-the-icons-fonts
    emacsUnstable

    emacsPackages.vterm
    emacsPackages.pdf-tools
    emacsPackages.org
    emacsPackages.org-plus-contrib
  ];
}
