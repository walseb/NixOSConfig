{ ... }:

let
  caches = [
    "https://cache.nixos.org/"

    "https://nixcache.reflex-frp.org"

    # Haskell.nix
    # "https://hydra.iohk.io"

    "https://nix-community.cachix.org"

    # https://github.com/shajra/haskell-hls-nix
    # "https://shajra.cachix.org"
  ];

  cachesKeys = [
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="

    # haskell.nix
    # "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="

    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

    # https://github.com/shajra/haskell-hls-nix
    # "shajra.cachix.org-1:V0x7Wjgd/mHGk2KQwzXv8iydfIgLupbnZKLSQt5hh9o="
  ];
in {
  nix = {
    package = pkgs.nixFlakes;
    # package = pkgs.nixUnstable;

    # Don't garbage collect nix-shell
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
      show-trace = true
    '';

    # Needed to be able to use custom channels in home-manager
    settings = {
      trusted-users = [ "root" "admin" ];

      experimental-features = [ "nix-command" "flakes" ];

      # Add binary caches
      # useSandbox = true;
      trusted-substituters = caches;
      trusted-public-keys = cachesKeys;

      auto-optimise-store = true;
    };
  };

  # https://github.com/NixOS/nixpkgs/commits/nixpkgs-unstable
  environment.variables.MY_NIXPKGS = "github:nixos/nixpkgs/635a306fc8ede2e34cb3dd0d6d0a5d49362150ed";
}
