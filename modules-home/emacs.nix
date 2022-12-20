# https://hydra.nix-community.org/project/emacs-overlay
# https://hydra.nix-community.org/jobset/emacs-overlay/unstable
# { pkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz" ) {}, ... }:
{ pkgs, ... }:
{
  # Emacs overlay
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      # "https://github.com/nix-community/emacs-overlay/archive/b14b8b133d98c923071ec2e20eff3c76bd80d173.tar.gz";
    }))
  ];

  home.packages = with pkgs; [
    # environment.systemPackages = with pkgs; [
    #emacs
    # emacsGit

    # emacsGitNativeComp
    # emacsNativeComp
    emacsUnstable
    # emacs-all-the-icons-fonts
    # emacsUnstable

    emacsPackages.vterm
    emacsPackages.pdf-tools
    emacsPackages.org
    # emacsPackages.org-plus-contrib
  ];
}
