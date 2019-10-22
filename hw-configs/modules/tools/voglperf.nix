with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "voglperf";
  version = "2019";

  src = fetchFromGitHub {
    sha256 = "0vwnb79r8fh3yigrscjc7hsmmlcrjhf2dsqqvhzj5lkz5azwy66b";
    rev = "05d2b254698697ff341b4b33b28243eea9698f6d";
    repo = "voglperf";
    owner = "ValveSoftware";
  };

  buildInputs = [
    ncurses
    cmake
  ];

  installPhase = ''
# It doesn't even make it here, it crashes after setting up cmake files
cd voglperf
  # make voglperf64
'';
}
