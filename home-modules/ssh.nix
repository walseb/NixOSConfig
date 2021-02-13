{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    controlMaster = "yes";

    matchBlocks =
      {
        "github.com" = {
          identityFile = "~/.ssh/id_rsa-github";
          identitiesOnly = true;
          user = "walseb";
        };
      };
  };
}
