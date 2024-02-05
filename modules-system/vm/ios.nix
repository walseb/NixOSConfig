{ nixThePlanetPkgs, lib, ...}:
let
  # 100 gb
  iosPkg = nixThePlanetPkgs.makeDarwinImage { diskSizeBytes = 100000000000; };
  # iosPkg = nixThePlanetPkgs.makeDarwinImage { diskSizeBytes = 60000000000; };
in
{
  environment.systemPackages = [
    # To ensure the package is never garbage collected. If the service is disabled and I run a garbage collection, it would be deleted
    # iosPkg
  ];

  # This ensures the package is protected from garbage collection
  environment.variables.IGNORE_THIS = "${iosPkg}";

  # systemd.services.macos-ventura.wantedBy = lib.mkForce [];
  services.macos-ventura = {
    # enable = true;
    # Create a 60GB Darwin disk image
    package = iosPkg;
    vncListenAddr = "0.0.0.0";
    # vncDisplayNumber = 5900;
    threads = 1;
    cores = 1;
  };
}
