{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Needs to be installed in the system config
    ntfs3g
  ];
}
