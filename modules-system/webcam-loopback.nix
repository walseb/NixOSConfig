{ pkg-s, ...}:
{
  environment.systemPackages = with pkg-s; [
    v4l-utils
  ];

  boot.extraModulePackages = [ pkg-s.linuxPackages.v4l2loopback ];

  # boot.extraModprobeConfig = "options v4l2loopback video_nr=5";
}
