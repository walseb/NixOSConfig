{ pkgs }:

(pkgs.fetchFromGitHub {
  repo = "emacs-overlay";
  owner = "nix-community";
  sha256 = "0f4pxv74nlwzwdsw8qpajfvlrxfngsdmnllgj6vkvbbz08ljyj6l";
  rev = "9815e71dd833db0b076072df6f7ea46737854470";

 # Stable 30.05 
  # sha256 = "1x8kbalj5dki7cn86mrms8vxrbznlrv4kba89l6v0hvr22w75igd";
  # rev = "a4c1f4b163c9ba956a6d09476a2fcb1feb9057ea";
})
