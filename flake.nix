{
  description = "NixOS configuration";

  inputs = {
    nur.url = github:nix-community/NUR;
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    # home-manager.url = "github:nix-community/home-manager";
    
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, nur, ... }: {
    nixosConfigurations = {
      "thinkpad-t480" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          ./users/thinkpad-t480.nix


          {
            home-manager.useGlobalPkgs = true;
            # By default packages will be installed to $HOME/.nix-profile but they can be installed to /etc/profiles if is added to the system configuration. This is necessary if, for example, you wish to use nixos-rebuild build-vm. This option may become the default value in the future.
            home-manager.useUserPackages = false;

            home-manager.users.admin = {
              imports = [
                nur.nixosModules.nur

                ./users/thinkpad-t480-home.nix
              ];
            };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
