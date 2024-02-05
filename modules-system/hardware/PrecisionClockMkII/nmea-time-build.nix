with import <nixpkgs> {};
with pkg-s.python3Packages;

buildPythonPackage rec {
  name = "nmea-time";
  src = pkg-s.fetchFromGitHub {
    owner = "walseb";
    repo = "nmea-time-simplified";
    rev = "94899452c64702a5d0086a9dde05d3033dee309e";
    sha256 = "1mw70h4c090w1s9yj6hdw7j54vvscis9zchdmpqii5k32b25y85a";
  };
  propagatedBuildInputs = [ pkg-s.python39Packages.pyserial pkg-s.python39Packages.iso8601 ];
}
