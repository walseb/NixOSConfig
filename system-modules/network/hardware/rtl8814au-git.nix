{ pkgs, ...}:

{
  nixpkgs.config.packageOverrides = pkgs: rec {
    my-rtl8814au = pkgs.linuxPackages.rtl8814au.overrideDerivation (attrs: {
      name = "my-rtl8814au";
      src = pkgs.fetchFromGitHub {
        owner = "aircrack-ng";
        repo = "rtl8814au";
        rev = "bdf80b5a932d5267cd1aff66fee8ac244cd38777";
        sha256 = "07m1wg2xbi60x1l1qcn7xbb7m2lfa9af61q2llqryx30m9rk2idk";
      };
    });
  };
}
