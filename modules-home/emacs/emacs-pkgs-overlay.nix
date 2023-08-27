{ pkgs }:

(pkgs.fetchFromGitHub {
  repo = "emacs-overlay";
  owner = "nix-community";
  sha256 = "11zi3f8rh6jzs1nd4a26k8b0p8g1hgag642xf6nplm1qyys3ns99";
  rev = "e4959460ea8e7d122baab8fd967bc604df928bec";
})
