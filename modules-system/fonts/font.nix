{ pkgs, ... }:
let selectedFont =
      # "Px437 IBM VGA 8x16";
    "Roboto Mono";
    # "Fragment Mono";
    # "IBM Plex Mono";
in
{
  fonts.fonts = with pkgs; [
    # (import ./my-inconsolata-lgc.nix)
    # (import ./scientifica.nix)
    # (import ./BlockZone.nix)
    (import ./BQN386.nix)
    # (import ./DejaVuBQNSansMono.nix)
    # iosevka-comfy.comfy 
    iosevka-comfy.comfy-fixed
    iosevka-comfy.comfy-wide-fixed

    # Takes 400 mb unpacked
    # iosevka
    cozette

    (import ./KreativeSoftware.nix)
    (import ./monocraft.nix)
    (import ./jingleberry.nix)

    (import ./ITC-Avant-Garde-Gothic-Medium.nix)

    (import ./LeagueSpartan.nix)

    (import ./fragment-mono.nix)

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

  fonts.fontconfig.defaultFonts.monospace = [selectedFont];
  fonts.fontconfig.defaultFonts.sansSerif = [selectedFont];
  fonts.fontconfig.defaultFonts.serif = [selectedFont];

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
