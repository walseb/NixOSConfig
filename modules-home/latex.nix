{ pkg-s, ... }: {
  # How to select only certain packages
  # (texlive.combine { inherit (texlive) scheme-small wrapfig ulem capt-of; });
}

  #   { pkg-s, ... }:

  # let
  #   myLatex = with pkg-s; (texlive.combine { inherit (texlive) scheme-small wrapfig ulem capt-of; });
  # in
  # {
  #   home.packages = with pkg-s; [
  #   ] ++ lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
  #     myLatex
  #   ];
  # }
