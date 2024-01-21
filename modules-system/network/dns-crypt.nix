{
  imports = [
    # ./dns-relay.nix
  ];

  # https://nixos.wiki/wiki/Encrypted_DNS
  networking = {
    nameservers = [ "::1" ];
    # resolvconf.enable = false;
    resolvconf.useLocalResolver = true;

    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      # Sample config
      # https://raw.githubusercontent.com/DNSCrypt/dnscrypt-proxy/master/dnscrypt-proxy/example-dnscrypt-proxy.toml

      force_tcp = false;
      ipv6_servers = false;
      require_dnssec = true;
      dnscrypt_servers = true;
      doh_servers = true;
      # http_proxy = "https://resolver.dnspoint.cloud/dns-query";
      block_ipv6 = false;
      require_nolog = true;
      require_nofilter = true;

      cloaking_rules = "/etc/nixos/nixos-private-config/dnscrypt-hosts.txt";

      server_names = ../../nixos-private-config/dns.nix.myDnsServers;

      sources.public-resolvers = {
        # https://github.com/DNSCrypt/dnscrypt-proxy/wiki/DNS-server-sources
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/dnscrypt-resolvers/v3/public-resolvers.md"
        ];

        cache_file = "/tmp/dnscrypt-proxy2/public-resolvers.md";
        # cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };
}
