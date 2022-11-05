with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "Cortex Command";
  version = "master";

  srcs = [
    (fetchFromGitHub {
      sha256 = "1szw9WX6jq3C/svnOfEOoC4U/U7DONPfdqMvfBS93rk=";
      rev = "40e957054768ab963f06d2405692a9073af1cff9";
      repo = "Cortex-Command-Community-Project-Source";
      owner = "cortex-command-community";
    })

    (fetchFromGitHub {
      sha256 = "qUycoQsS837sOanaUh/xaJl2cfYorgFb8L964DmK8Ag=";
      rev = "583e9734c41d183551fd4ee24b9f68baef7255b5";
      repo = "Cortex-Command-Community-Project-Data";
      owner = "cortex-command-community";
    })
  ];

  buildInputs = [
    allegro boost flac luajit lua5_2 minizip lz4 libpng  meson ninja
    xorg.libX11
    xorg.libXi
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libXcursor
    xorg.libXinerama
    xorg.xmessage

  ];

  # phases = [ "installPhase" ]; # Removes all phases except installPhase
  dontUnpack = true;

  buildPhase = ''
    ls
    cd Cortex-Command-Community-Project-Source
    echo "running ls"
    ls
    echo "ls run"
  '';
  # meson build
  #   ninja -C build

}
