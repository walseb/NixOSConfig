{pkg-s, ...}:
{

  environment.systemPackages = with pkg-s; [
    # Needed by book maker automation
    librsvg

    # Needed for KDP cover maker
    texlive.combined.scheme-medium

    # Needed for PDF jam
    # texliveMedium
    # ocamlPackages.cpdf
  ];
}
