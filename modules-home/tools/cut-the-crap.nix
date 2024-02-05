{ pkg-s, haskellPackages, ... }:
{
  nixpkgs.config = {
    packageOverrides = pkg-s: {
      haskellPackages.cut-the-crap-my = (pkg-s.haskellPackages.cut-the-crap.override { }).overrideAttrs (old: rec {
        src = pkgs.fetchFromGitHub {
          owner = "walseb";
          repo = "cut-the-crap";
          rev = "29bd92b510cf10873f92c38f3b96b3e65222204c";
          sha256 = "08bxwh2b8ih1pxdsqlks0byy9cfx8fln047a8q40n8ax45qyjybm";
        };
      });
    };
  };
}
