{ pkg-s, nixThePlanetPkgs, lib, ...}:
let
  # iosPkg = nixThePlanetPkgs.makeDarwinImage { diskSizeBytes = 200000000000; };
  # 120 gb
  iosPkg = nixThePlanetPkgs.makeDarwinImage { diskSizeBytes = 120000000000; };
  # iosPkg = nixThePlanetPkgs.makeDarwinImage { diskSizeBytes = 60000000000; };
in
{
  environment.systemPackages = [
    # To ensure the package is never garbage collected. If the service is disabled and I run a garbage collection, it would be deleted
    # iosPkg
    # VNC
    pkg-s.krdc # krdc localhost cached-nix-shell -p krdc --command 'krdc localhost'
  ];

  # This ensures the package is protected from garbage collection
  # environment.variables.IGNORE_THIS = "${iosPkg}";

  # systemd.services.macos-ventura.wantedBy = lib.mkForce [];
  # Password is "admin"
  services.macos-ventura = {
    # enable = true;
    # autoStart = true;
    # Create a 60GB Darwin disk image
    package = iosPkg;
    vncListenAddr = "0.0.0.0";
    # vncDisplayNumber = 5900;
    threads = 4;
    cores = 2;
    mem = "8G";
  };
}
