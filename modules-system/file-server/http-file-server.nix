{pkg-s, ...}:
{
  environment.systemPackages = with pkg-s; [
    static-web-server
  ];

  services.static-web-server = {
    enable = true;
    root = "/tmp/public-file-share";
    listen = "[::]:8777";
  };

  networking.firewall.allowedTCPPorts = [ 8777 ];
}
