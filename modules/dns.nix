# https://nixos.wiki/wiki/Encrypted_DNS
{ config, pkgs, ... }:
{
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
      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml

      force_tcp = false;
      ipv6_servers = false;
      require_dnssec = true;
      dnscrypt_servers = true;
      doh_servers = true;
      # http_proxy = "https://resolver.dnspoint.cloud/dns-query";
      block_ipv6 = true;
      require_nolog = true;
      require_nofilter = true;

      sources.public-resolvers = {
        # https://github.com/DNSCrypt/dnscrypt-proxy/wiki/DNS-server-sources
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/opennic.md"
          "https://download.dnscrypt.info/resolvers-list/v2/opennic.md"
        ];

        cache_file = "/var/lib/dnscrypt-proxy2/opennic.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v2/public-resolvers.md
      # server_names = [ ... ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy2";
  };
}
