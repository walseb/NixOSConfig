{ pkg-s-path, ... }: {
  home.sessionVariables.NIX_PATH = "nixpkgs=${pkg-s-path}";
}
