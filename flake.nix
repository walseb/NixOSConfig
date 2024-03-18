{
  description = "NixOS configuration";

  # nixConfig = {

  #   extra-substituters = [
  #     "https://nix-gaming.cachix.org"

  #     "https://cache.nixos.org/"

  #     "https://nixcache.reflex-frp.org"

  #     "https://nix-community.cachix.org"
  #   ];

  #   extra-trusted-public-keys = [
  #     "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="

  #     "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="

  #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

  #   ];
  # };


  inputs =
    # let
    #   homeManagerRepo = "github:nix-community/home-manager/release-23.11";
    #   # github:NixOS/nixpkgs/nixos-unstable
    #   nixpkgsRepo = "nixpkgs/nixos-23.11";
    # in

    # Find which need follows: nix flake info

      {
        # nixos-version.url = "23.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

        # Fast
        nixpkgs.url = "nixpkgs/nixos-23.11";
        # nixpkgs.url = "nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # For now, use unstable
        # home-manager.url = "github:nix-community/home-manager";
        # home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

        flake-utils.url = "github:numtide/flake-utils";

        # Slow lane
        nixpkgs-slow.url = "nixpkgs/nixos-23.11";
        nur.url = "github:nix-community/NUR";

        # Emacs
        # https://github.com/nix-community/emacs-overlay/blob/master/flake.nix
        nixpkgs-emacs.url = "nixpkgs/nixos-unstable";

        # emacs-overlay.url = "github:nix-community/emacs-overlay";

        emacs-overlay = {
          url = "github:nix-community/emacs-overlay";
          inputs.nixpkgs.follows = "nixpkgs-emacs";
          inputs.flake-utils.follows = "flake-utils";
          inputs.nixpkgs-stable.follows = "nixpkgs-slow";
        };
        # emacs-overlay = {
        #   url = "github:nix-community/emacs-overlay";
        #   inputs.nixpkgs.follows = "nixpkgs-emacs";
        #   inputs.flake-utils.follows = "flake-utils";
        #   # inputs.nixpkgs-stable.follows = "nixpkgs-emacs";
        # };

        # Never bump
        nixtheplanet-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixtheplanet.url = "github:matthewcroughan/nixtheplanet";

        nixtheplanet.inputs.osx-kvm.follows = "my-osx-kvm";

        my-osx-kvm = {
          url = "github:kholia/OSX-KVM";
          flake = false;
        };

        nixtheplanet.inputs.nixpkgs.follows = "nixtheplanet-nixpkgs";

        nix-gaming.url = "github:fufexan/nix-gaming";
        nix-gaming.inputs.nixpkgs.follows = "nixpkgs-slow";
      };

  # Alternative split module
  # https://github.com/librephoenix/nixos-config/blob/main/flake.nix
  outputs = inputs@{ nixpkgs, nixpkgs-slow, nixpkgs-unstable , home-manager, nur, nixpkgs-emacs, emacs-overlay , nixtheplanet, nixtheplanet-nixpkgs, ... }:
    let
      # "Px437 IBM VGA 8x16";
      # "jetbrains mono";
      # "Roboto Mono";
      # "Iosevka Comfy Wide Fixed";
      # "Iosevka Comfy Wide"
      # "Fragment Mono";
      # "IBM Plex Mono";
      # [[file:/etc/nixos/modules-system/fonts/font.nix][Link]]
      my_font = "Iosevka Comfy Wide Fixed";

      nixThePlanetPkgs = (import nixtheplanet-nixpkgs { system = "x86_64-linux"; overlays = [ nixtheplanet.overlays.default ]; });

      emacs-overlay-import = import nixpkgs-emacs {
        overlays = [ (import emacs-overlay) ];
      };

      pkgs-u = import nixpkgs-unstable { };

      pkg-s = import nixpkgs-slow {
        # config.allowUnfree = true;
        # nixpkgs.config.allowUnfree = true;
        nixpkgs.config = {
          # allowBroken = true;
          allowUnfree = true;
        };

        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "ocaml4.14.1-cpdf"

          "steam"
          "steam-run"
          "steam-original"
          "steam-runtime"
          "android-studio-stable"
          "languagetool"
        ];
      };
      pkg-s-path = nixpkgs-slow;

      system = user-system: user-home: {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkg-s;
          inherit pkg-s-path;
          inherit nixThePlanetPkgs;
          inherit pkgs-u;
          inherit my_font;

          # inherit nixos-version;
          nixos-version = "23.11";
        };

        modules = [
          inputs.nix-gaming.nixosModules.steamCompat

          ./configuration.nix

          home-manager.nixosModules.home-manager

          user-system

          nixtheplanet.nixosModules.macos-ventura

          {
            home-manager.useGlobalPkgs = true;
            # By default packages will be installed to $HOME/.nix-profile but they can be installed to /etc/profiles if is added to the system configuration. This is necessary if, for example, you wish to use nixos-rebuild build-vm. This option may become the default value in the future.
            home-manager.useUserPackages = false;

            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit pkg-s;
              inherit pkg-s-path;
              emacs-overlay = emacs-overlay-import;
              inherit pkgs-u;
              inherit my_font;
              # nixos-version = nixos-version;
              nixos-version = "23.11";
            };

            home-manager.users.admin = {
              imports = [
                nur.nixosModules.nur

                ./home.nix
                user-home
              ];
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        "thinkpad-t480" = nixpkgs.lib.nixosSystem (system ./users/thinkpad-t480/system.nix ./users/thinkpad-t480/home.nix);
        "nuc" = nixpkgs.lib.nixosSystem (system ./users/nuc/system.nix ./users/nuc/home.nix);
      };
    };
}
