{ pkgs }:

(pkgs.fetchFromGitHub {
  repo = "emacs-overlay";
  owner = "nix-community";
  sha256 = "13vff14ik9qc8qj1hxfmdwdz2893cnqr25wb8bfbwyhiczs1zrd0";
  rev = "e9cef3633f160bf671b9196bce99467629b5133e";
})
