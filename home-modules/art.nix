{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Once support is better, try this OSS driver
    # digimend.enable = true;
    # Supported tablets:
    # http://digimend.github.io/drivers/digimend/tablets/
    pentablet-driver

    krita
  ];
}
