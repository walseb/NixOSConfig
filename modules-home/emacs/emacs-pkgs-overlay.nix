{ pkgs }:

(pkgs.fetchFromGitHub {
  repo = "emacs-overlay";
  owner = "nix-community";
  sha256 = "0m6fqxxfq67h84cn39hv45fxkrdx89wd7n3imm8m3x69fxx1sn91";
  rev = "2db8934d6ec0a50effad0cf4dfbcdd496d0d2fdc";
})
