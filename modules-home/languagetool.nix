{ pkgs, ... }:
{
  # TODO download N-gram

  home.packages = with pkgs; [
    languagetool
    # Needed to call langtool jar
    # adoptopenjdk-jre-bin
  ];
}

