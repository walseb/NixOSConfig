{ ... }:

{
  # Virtual terminal.
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = ''
      palette=solarized-dark
      font-size=16
    '';
    # font-name=Iosevka Slab
  };
}
