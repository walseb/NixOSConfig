with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonPackage rec {
  name = "nmea-time";
  src = pkgs.fetchFromGitHub {
    owner = "walseb";
    repo = "nmea-time-simplified";
    rev = "0bcd10d1505f69b84f5352c7dc76d573d0f744a7";
    sha256 = "0c6n9475lp2s9gf6054xgy7qifsdmizbxzc9f1ah6k0y63wa5amh";
  };
  propagatedBuildInputs = [ pkgs.python39Packages.pyserial pkgs.python39Packages.iso8601 ];
}
