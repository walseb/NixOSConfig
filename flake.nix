{
  description = "NixOS configuration";

  inputs =
    # let
    #   homeManagerRepo = "github:nix-community/home-manager/release-23.11";
    #   # github:NixOS/nixpkgs/nixos-unstable
    #   nixpkgsRepo = "nixpkgs/nixos-23.11";
    # in
    {
      nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

      # Fast
      nixpkgs.url = "nixpkgs/nixos-23.11";
      home-manager.url = "github:nix-community/home-manager/release-23.11";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      flake-utils.url = "github:numtide/flake-utils";

      # Slow lane
      nixpkgs-slow.url = "nixpkgs/nixos-23.11";
      nur.url = "github:nix-community/NUR";

      # Emacs
      nixpkgs-emacs.url = "nixpkgs/nixos-23.11";
      emacs-overlay = {
        url = "github:nix-community/emacs-overlay";
        inputs.nixpkgs.follows = "nixpkgs-emacs";
        # inputs.flake-utils.follows = "flake-utils";
      };

      nixtheplanet-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nixtheplanet.url = "github:matthewcroughan/nixtheplanet";

      nixtheplanet.inputs.nixpkgs.follows = "nixtheplanet-nixpkgs";

      nix-gaming.url = "github:fufexan/nix-gaming";
      nix-gaming.inputs.nixpkgs.follows = "nixpkgs-slow";
    };

  # Alternative split module
  # https://github.com/librephoenix/nixos-config/blob/main/flake.nix
  outputs = inputs@{ nixpkgs, nixpkgs-slow, nixpkgs-unstable
                   , home-manager, nur
                   # Emacs
                   , nixpkgs-emacs, emacs-overlay
                   , nixtheplanet, nixtheplanet-nixpkgs
                   , ... }:
                     let
                       nixThePlanetPkgs = (import nixtheplanet-nixpkgs { system = "x86_64-linux"; overlays = [ nixtheplanet.overlays.default ]; });

                       emacs-overlay-import = import nixpkgs-emacs {
                         overlays = [ (import emacs-overlay) ];
                       };

                       pkgs-u = import nixpkgs-unstable { };

                       pkg-s = import nixpkgs-slow {
                         # config.allowUnfree = true;
                         # nixpkgs.config.allowUnfree = true;
                         config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
                           "steam"
                           "steam-run"
                           "steam-original"
                           "steam-runtime"
                           "android-studio-stable"
                           "languagetool"
                         ];
                       };
                       pkg-s-path = nixpkgs-slow;
                     in {
                       nixosConfigurations = {
                         "thinkpad-t480" = nixpkgs.lib.nixosSystem {
                           system = "x86_64-linux";

                           specialArgs = {
                             inherit inputs;
                             inherit pkg-s;
                             inherit pkg-s-path;
                             inherit nixThePlanetPkgs;
                             inherit pkgs-u;
                           };

                           modules = [
                             inputs.nix-gaming.nixosModules.steamCompat

                             ./configuration.nix

                             home-manager.nixosModules.home-manager

                             ./users/thinkpad-t480.nix

                             nixtheplanet.nixosModules.macos-ventura

                             {
                               home-manager.useGlobalPkgs = true;
                               # By default packages will be installed to $HOME/.nix-profile but they can be installed to /etc/profiles if is added to the system configuration. This is necessary if, for example, you wish to use nixos-rebuild build-vm. This option may become the default value in the future.
                               home-manager.useUserPackages = false;

                               home-manager.extraSpecialArgs = {
                                 inherit inputs;
                                 inherit pkg-s;
                                 emacs-overlay = emacs-overlay-import;
                                 inherit pkgs-u;
                               };

                               home-manager.users.admin = {
                                 imports = [
                                   nur.nixosModules.nur

                                   ./users/thinkpad-t480-home.nix
                                 ];
                               };
                             }
                           ];
                         };
                       };
                     };
}
