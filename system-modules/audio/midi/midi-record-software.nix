{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    qsynth qtractor
  ];
}
