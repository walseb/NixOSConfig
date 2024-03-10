{ pkgs, pkg-s-path, pkg-s, lib, ... }:


{
  nixpkgs.config = {
    # allowBroken = true;
    allowUnfree = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam-original"

    "ocaml4.14.1-cpdf"
    "languagetool"
  ];

  nix = {
    registry.nixpkgs.flake = pkg-s-path;

    nixPath = [
      "nixpkgs=${pkg-s-path}"
    ];

    package = pkg-s.nixFlakes;
    # package = pkgs.nixUnstable;

    # Don't garbage collect nix-shell
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      show-trace = true
    '';

    # https://discourse.nixos.org/t/do-flakes-also-set-the-system-channel/19798/2
    # registry.nixpkgs.flake = unstable;

    # https://discourse.nixos.org/t/correct-way-to-use-nixpkgs-in-nix-shell-on-flake-based-system-without-channels/19360/6
    # https://discourse.nixos.org/t/correct-way-to-use-nixpkgs-in-nix-shell-on-flake-based-system-without-channels/19360/3
    # nixPath = [
    #   "nixpkgs=${nixpkgsPath}"
    #   "/nix/var/nix/profiles/per-user/root/channels"
    # ];
    # nixPath = [ "nixpkgs=${pkg-s}" ];

    # Needed to be able to use custom channels in home-manager
    settings = {
      # Remove?
      trusted-users = [ "root" "admin" ];

      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];

      # binary-caches-parallel-connections = 40;

      

      trusted-substituters = [
        "https://nix-gaming.cachix.org"

        "https://cache.nixos.org/"

        "https://nixcache.reflex-frp.org"

        "https://nix-community.cachix.org"
      ];

      substituters = [
        "https://nix-gaming.cachix.org"

        "https://cache.nixos.org/"

        "https://nixcache.reflex-frp.org"

        "https://nix-community.cachix.org"
      ];

      
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="

        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="

        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

      ];
    };
  };

  # https://github.com/NixOS/nixpkgs/commits/nixpkgs-unstable
  # Deprecated
  # environment.variables.MY_NIXPKGS = "github:nixos/nixpkgs/635a306fc8ede2e34cb3dd0d6d0a5d49362150ed";
}
