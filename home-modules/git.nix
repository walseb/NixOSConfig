{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Sebastian Wålinder";
    userEmail = "s.walinder@gmail.com";
  };
}
