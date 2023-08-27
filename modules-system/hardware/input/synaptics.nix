{
  services.xserver.synaptics.enable = true;
  services.xserver.libinput.enable = false;

  services.xserver.synaptics.twoFingerScroll = true;
  services.xserver.synaptics.maxSpeed = "1.0";
  services.xserver.synaptics.minSpeed = "1.0";
  services.xserver.synaptics.accelFactor = "0";
  services.xserver.synaptics.scrollDelta = 100;
  services.xserver.synaptics.additionalOptions =
    ''Option "CornerCoasting" "0"'';

  services.xserver.synaptics.fingersMap = [1 3 2];

  services.xserver.synaptics.palmDetect = true;

  # For additional options, see
    # https://www.x.org/releases/X11R7.6/doc/man/man4/synaptics.4.xhtml#heading4
}
