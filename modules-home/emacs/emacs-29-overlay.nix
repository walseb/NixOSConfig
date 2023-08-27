{ pkgs }:

(pkgs.fetchFromGitHub {
  repo = "emacs-overlay";
  owner = "nix-community";
  sha256 = "14rfdwsy9pvsbxw9kb3nkzy28bvxgjgvas70i2mb82av9s1c5zn3";
  rev = "39aaaf0465f7278b9f28358ff154ed26475620fe";
})
