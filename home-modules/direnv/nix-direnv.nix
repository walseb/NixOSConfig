{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  # Then you also need to add this to your system config:
  # https://github.com/nix-community/nix-direnv
  # { pkgs, ... }: {
  #   nix.extraOptions = ''
  #   keep-outputs = true
  #   keep-derivations = true
  # '';
  # }
}
