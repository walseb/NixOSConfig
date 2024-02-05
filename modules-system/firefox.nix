{...}:
{
  environment.variables.MOZ_X11_EGL = "1";
  environment.variables.MOZ_USE_XINPUT2 = "1";
  # Store profiles/cache in RAM with periodic disk sync https://wiki.archlinux.org/title/profile-sync-daemon
  services.psd.enable = true;
}
