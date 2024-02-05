{ pkg-s, ... }:
{
  environment.systemPackages = with pkg-s; [
    # This doesn't have the elisp if you put it in home-manager
    mu
  ];
}
