{ emacs-overlay, ... }:


{
  home.packages = with emacs-overlay; [
    # Performance patch https://github.com/abo-abo/swiper/pull/2986
    # (emacsPackages.trivialBuild {
    #   pname = "swiper";
    #   version = "git";

    #   src = fetchFromGitHub {
    #     owner = "digikar99";
    #     repo = "swiper";
    #     sha256 = "p0S6MsMS32Msm0vhOENg3ULpx7do68KNVDAAtoKCt5U=";
    #     rev = "2b507d258de8d366006abd8d831b62a56cea5f97";
    #   };

    #   packageRequires = with emacsPackages; [avy hydra];
    # })

    # Re merge it to the main branch and owner after https://github.com/kiennq/emacs-mini-modeline/issues/53 has been resolved
    # (emacsPackages.trivialBuild {
    #   pname = "mini-modeline";
    #   version = "master";

    #   src = fetchFromGitHub {
    #     repo = "emacs-mini-modeline";
    #     owner = "10ne1"; # kiennq
    #     sha256 = "2dCf3y1/NYnUSoTCJ1WQEFNiKrrED05JRrPWZztByew=";
    #     rev = "8c239047c01a29fa7545ddc840c8fc98328534dc";
    #   };

    #   packageRequires = with emacsPackages; [dash];
    # })

    # (emacsPackages.trivialBuild {
    #   pname = "evil-textobj-anyblock";
    #   version = "unstable-2020-07-18";

    #   src = fetchFromGitHub {
    #     owner = "willghatch";
    #     repo = "evil-textobj-anyblock";
    #     sha256 = "gN2E/qCcneywTbLjq97Nc/RHhvCKQnsNhSfNNnm1CYA=";
    #     rev = "29280cd71a05429364cdceef2ff595ae8afade4d";
    #   };

    #   packageRequires = with emacsPackages; [cl-lib evil];

    # })
  ];
}
