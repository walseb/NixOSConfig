{ pkgs }:

(pkgs.fetchFromGitHub {
  repo = "emacs-overlay";
  owner = "nix-community";
  sha256 = "0asp5iqsaf06lrjlbpix4i9xa13v7qai6zpy3c3pdjdldn6zj231";
  rev = "6bd9fd951f5306ff81c01c38bc0e5773947aa349";

 # Stable 30.05
  # sha256 = "1x8kbalj5dki7cn86mrms8vxrbznlrv4kba89l6v0hvr22w75igd";
  # rev = "a4c1f4b163c9ba956a6d09476a2fcb1feb9057ea";
})


  # [2024-01-15 Mon 03:21] Quite stable except for memory leaks that perhaps were caused by this version of emacs
  # (pkgs.fetchFromGitHub {
  #   repo = "emacs-overlay";
  #   owner = "nix-community";
  #   sha256 = "1lzba4gg0i7vg61344i9ywi2l42krvmn6dbgy0h0r5g9c4zbvzn9";
  #   rev = "c1ecbd6ee4b45991444b511a22f88af2b920aee1";

  #   # Stable 30.05
  #   # sha256 = "1x8kbalj5dki7cn86mrms8vxrbznlrv4kba89l6v0hvr22w75igd";
  #   # rev = "a4c1f4b163c9ba956a6d09476a2fcb1feb9057ea";
  # })
