{pkg-s, ...}:
{
  services.sshd.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  environment.systemPackages = with pkg-s; [
    # Basic ssh packages
    ripgrep
  ];
}
