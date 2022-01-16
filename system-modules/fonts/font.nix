{ pkgs, ... }:
let selectedFont = "Roboto Mono"; # "IBM Plex Mono";
in
{
  fonts.fonts = with pkgs; [
    # (import ./my-inconsolata-lgc.nix)
    # (import ./scientifica.nix)
    # (import ./BlockZone.nix)

    ultimate-oldschool-pc-font-pack

    # hasklig

    # scientifica
    # spleen
    ibm-plex

    roboto-mono

    # inconsolata-lgc
    # inconsolata
  ];
  fonts.fontconfig.includeUserConf = true;

  fonts.fontconfig.defaultFonts.monospace = [selectedFont];
  fonts.fontconfig.defaultFonts.sansSerif = [selectedFont];
  fonts.fontconfig.defaultFonts.serif = [selectedFont];

  # Attempt at making zeroes dashed
  fonts.fontconfig.localConf = ''
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
    <match target="font">
      <edit name="fontfeatures" mode="append">
        <string>zero on</string>
      </edit>
    </match>
  </fontconfig>'';
}
