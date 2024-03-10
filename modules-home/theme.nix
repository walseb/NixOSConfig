{ pkg-s, my_font, ... }: {
  # Configure Cursor Theme
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    # package = pkg-s.google-cursor;
    # name = "GoogleDot-Blue";

    package = pkg-s.bibata-cursors;
    name = "Bibata-Modern-Ice";
    
    # 16x16 - Small
    # 24x24 - Regular
    # 32x32 - Large
    # 48x48 - Extra Large
    size = 24;
  };

  # Theme GTK
  gtk = {
    # Font configuration is in [[file:/etc/nixos/modules-system/fonts/font.nix][Link]]
    enable = true;
    theme.package = pkg-s.arc-theme;
    theme.name = "Arc-Dark";

    font = {
      name = my_font;
      # size = 12;
      # package = pkgs.ubuntu_font_family;
    };

    iconTheme.package = pkg-s.arc-icon-theme;
    iconTheme.name = "Arc";

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkg-s.adwaita-qt;
    };
  };
}
