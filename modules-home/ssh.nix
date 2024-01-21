{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    controlMaster = "yes";

    matchBlocks =
      {
        "github.com" = {
          identityFile = "~/.ssh/id_ed25519";
          identitiesOnly = true;
          user = "walseb";
        };
      };
  };
}
