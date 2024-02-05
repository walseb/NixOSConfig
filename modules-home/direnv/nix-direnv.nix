{ pkg-s, ... }:
{
  programs.direnv = {
    enable = true;
    package = pkg-s.direnv;
    nix-direnv.enable = true;
    nix-direnv.package = pkg-s.nix-direnv;
    enableBashIntegration = true;
  };

  # Then you also need to add this to your system config:
  # https://github.com/nix-community/nix-direnv
  # { pkg-s, ... }: {
  #   nix.extraOptions = ''
  #   keep-outputs = true
  #   keep-derivations = true
  # '';
  # }
}
