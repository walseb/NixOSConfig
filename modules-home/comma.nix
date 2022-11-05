{pkgs, ...}:
let
comma = import ( pkgs.fetchFromGitHub {
  owner = "fzakaria";
  repo = "comma";
  rev = "60a4cf8ec5c93104d3cfb9fc5a5bac8fb18cc8e4";
  sha256 = "16i4vkpbppqc7xv6w791awhj71blj42mj99mi2lx6949yn2xyavi";
}) { };
in
{
  home.packages = [ comma ];
}
