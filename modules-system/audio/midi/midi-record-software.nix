{ pkg-s, ... }: {
  environment.systemPackages = with pkg-s; [
    qsynth qtractor qjackctl
  ];
}
