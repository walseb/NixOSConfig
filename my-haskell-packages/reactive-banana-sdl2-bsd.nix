{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # packageOverrides = super: let self = super.pkgs; in
    packageOverrides = pkgs:
      {
        haskellPackages = pkgs.haskellPackages.override {
          overrides = self: super: {
            reactive-banana-sdl2-bsd = self.callPackage ./reactive-banana-sdl2 {};
          };
        };
      };
  };
}
