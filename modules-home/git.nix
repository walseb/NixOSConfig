{ pkgs, ... }:
# Deep setup:
# https://github.com/bbigras/nix-config/blob/master/users/bbigras/core/git.nix
{
  programs.git = {
    enable = true;
    userName = "Sebastian Wålinder";
    userEmail = "s.walinder@gmail.com";
  };
}


