{
  imports = [
    ./sshd.nix
  ];

  services.openssh.forwardX11 = true;
}
