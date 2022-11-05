{
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      sources.relays = {
        urls = [
          "https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/relays.md"
          "https://download.dnscrypt.info/dnscrypt-resolvers/v3/relays.md"
        ];

        cache_file = "/var/lib/dnscrypt-proxy2/relays.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        # refresh-delay = 100;
      };

      anonymized_dns = {
        # TODO: Requires ~2.0.42
        # skip_incompatible = true;
        # direct_cert_fallback = false;

        routes = [
          { server_name = "*"; via=(import ../../nixos-private-config/dns.nix).myDnsRelays; }
        ];
      };
    };
  };
}
