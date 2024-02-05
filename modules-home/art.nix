{ pkg-s, ... }:
{
  home.packages = with pkg-s; [
    # Once support is better, try this OSS driver
    # digimend.enable = true;
    # Supported tablets:
    # http://digimend.github.io/drivers/digimend/tablets/
    pentablet-driver

    krita
  ];
}
