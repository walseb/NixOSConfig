{pkgs-u, ...}:
{
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = pkgs-u.linuxPackages_latest;
}
