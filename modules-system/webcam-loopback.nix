{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    v4l-utils
  ];

  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  # boot.extraModprobeConfig = "options v4l2loopback video_nr=5";
}
