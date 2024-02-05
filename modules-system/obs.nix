{ pkg-s, ...}:
{
  environment.systemPackages = with pkg-s; [
    (pkg-s.wrapOBS {
      plugins = with pkg-s.obs-studio-plugins; [
        obs-vaapi
      ];
    })

    #   (obs-studio.override { plugins = [ obs-studio-plugins.obs-vaapi ]; })
  ];


  # boot.kernelModules = [ "v4l2loopback" ];

    # boot.extraModulePackages = [
    #   config.boot.kernelPackages.v4l2loopback.out
    # ];
}
