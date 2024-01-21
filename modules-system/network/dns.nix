{
  networking = {
    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    # resolvconf.enable = false;
    # resolvconf.useLocalResolver = true;

    # If using dhcpcd:
    # dhcpcd.extraConfig = "nohook resolv.conf";
    # # If using NetworkManager:
    # networkmanager.dns = "none";
  };

  services.resolved = {
    enable = true;
    # dnssec = "true";
    # domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    #   extraConfig = ''
    #   DNSOverTLS=yes
    # '';
  };
}
