with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "Scowl Aspell American";

  # src = ./scowl-aspell-american.alias;
  src = builtins.path {
    name = "aliases";
    path = ./aliases;
  };

  nativeBuildInputs = [ aspell ];

  # dontUnpack = true;

  installPhase = ''
    mkdir -p "$out/lib/aspell"
    cp -r scowl-aspell-american.alias "$out/lib/aspell"
    '';
}
