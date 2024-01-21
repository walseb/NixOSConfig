with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "Jingleberry";
  version = "master";

  # propagatedBuildInputs = with pkgs; [
  #   unzip
  # ];
  dontUnpack = true;

  # src = [ ./jingleberry/Jingleberry.otf ];

  # src = fetchurl {
  #   url = "https://freefontsdownload.net/download/157954/jingleberry.zip";
  #   sha256 = "sha256-5ZrjgT2zjtKz3S+VBHnqF/SVuaYoQKLw5VQy00guNCw=";
  # };

  src = ./jingleberry;

  # setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/share/fonts/opentype;
    cp $src/Jingleberry.otf $out/share/fonts/opentype;
    '';
}
