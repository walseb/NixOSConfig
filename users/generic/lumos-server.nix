{pkg-s, ...}:
{

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

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
