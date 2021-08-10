with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonPackage rec {
  name = "nmea-time";
  src = pkgs.fetchFromGitHub {
    owner = "walseb";
    repo = "nmea-time-simplified";
    rev = "94899452c64702a5d0086a9dde05d3033dee309e";
    sha256 = "1mw70h4c090w1s9yj6hdw7j54vvscis9zchdmpqii5k32b25y85a";
  };
  propagatedBuildInputs = [ pkgs.python39Packages.pyserial pkgs.python39Packages.iso8601 ];
}
