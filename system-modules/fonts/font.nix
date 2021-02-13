{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    # (import ./my-inconsolata-lgc.nix)
    # (import ./scientifica.nix)
    # (import ./BlockZone.nix)

    ultimate-oldschool-pc-font-pack

    hasklig
    # inconsolata-lgc
    # inconsolata
  ];
  fonts.fontconfig.includeUserConf = true;

  fonts.fontconfig.defaultFonts.monospace = ["Hasklig"];
  # fonts.fontconfig.defaultFonts.sansSerif = ["Hasklig"];
  # fonts.fontconfig.defaultFonts.serif = ["Hasklig"];

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
