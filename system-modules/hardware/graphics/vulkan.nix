{ pkgs, ... }:
{
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = with pkgs;
    [
      vulkan-tools
    ];
}
