{ pkg-s, my_font, ... }:
{
  fonts.packages = with pkg-s; [
    # (import ./my-inconsolata-lgc.nix)
    # (import ./scientifica.nix)
    # (import ./BlockZone.nix)
    jetbrains-mono

    (import ./BQN386.nix {inherit pkg-s;})
    # (import ./DejaVuBQNSansMono.nix)
    # iosevka-comfy.comfy
    iosevka-comfy.comfy-fixed
    iosevka-comfy.comfy-wide-fixed

    # Takes 400 mb unpacked
    # iosevka
    cozette

    #    (import ./KreativeSoftware.nix)
    #   (import ./monocraft.nix)
    (import ./jingleberry.nix {inherit pkg-s;})

    (import ./ITC_Avant_Garde_Gothic_Medium.nix {inherit pkg-s;})

    (import ./LeagueSpartan.nix {inherit pkg-s;})

    #  (import ./fragment-mono.nix)

    ultimate-oldschool-pc-font-pack

    # hasklig

    # scientifica
    # spleen
    ibm-plex

    roboto-mono
    roboto

    # inconsolata-lgc
    # inconsolata
  ];

  fonts.fontconfig.includeUserConf = true;

  fonts.fontconfig.defaultFonts.monospace = [my_font];
  fonts.fontconfig.defaultFonts.sansSerif = [my_font];
  fonts.fontconfig.defaultFonts.serif = [my_font];

  # Attempt at making zeroes dashed
  # fonts.fontconfig.localConf = ''
  # <?xml version="1.0"?>
  # <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  # <fontconfig>
  #   <match target="font">
  #     <edit name="fontfeatures" mode="append">
  #       <string>zero on</string>
  #     </edit>
  #   </match>
  # </fontconfig>'';

}
