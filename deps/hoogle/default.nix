{ # Fetch the latest haskell.nix and import its default.nix
  haskellNix ? import (builtins.fetchTarball "https://github.com/input-output-hk/haskell.nix/archive/master.tar.gz") {}

, nixpkgsSrc ? haskellNix.sources.nixpkgs

, nixpkgsArgs ? haskellNix.nixpkgsArgs

, pkgs ? import nixpkgsSrc nixpkgsArgs
}: pkgs.haskell-nix.project {
  # 'cleanGit' cleans a source directory based on the files known by git
  src = pkgs.haskell-nix.haskellLib.cleanSourceWith {
    name = "HoogleDeps";
    src = ./.;
  };
  # Specify the GHC version to use.
  compiler-nix-name = "ghc884"; # Not required for `stack.yaml` based projects.
}
