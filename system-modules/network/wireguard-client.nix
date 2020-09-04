# https://nixos.wiki/wiki/Wireguard
{ nat-addr, ... }:
{
  # Enable Wireguard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      address = [ nat-addr ];

      privateKeyFile = "/home/admin/pkg-keys/wireguard-key-private";

      peers = [
        # For a client configuration, one peer entry for the server will suffice.
        {
          # Public key of the server (not a file path).
          publicKey = (import ../../nixos-private-config/servers.nix).mainServerWireguardPublicKey;

          presharedKey = "VMC46nt/d8uF/87c8BHjSDXJwcRGgaAV/I8nSITLPbU=";

          # Forward all the traffic via VPN.
          allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Set this to the server IP and port.
          endpoint = (import ../../nixos-private-config/servers.nix).mainServer + ":51820";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
