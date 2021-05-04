let
  project = import ./default.nix {};
in
project.shellFor {
  packages = ps: [ ps.HoogleDeps ];
  withHoogle = true;
}
