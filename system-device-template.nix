# * Config
let
  # Generate using ~mkpasswd -m sha-512~ contained in package ~mkpasswd~
  pass = null;
  # Check ./nixos-private-config/vpn-clients.nix
  # my-nat-addr = null;
in
{
  # ** Imports
  imports = [
    # ./system-hw-configs/x200-libreboot.nix
    # ./system-hw-configs/vbox.nix
    # ./system-hw-configs/vps.nix
    # ./system-hw-configs/ideapad.nix

    # ./system-modules/network/sshd.nix
    # ./system-modules/network/sshd-xorg.nix

    # ./system-modules/network/wireguard-server.nix
    # (import ./system-modules/network/wireguard-client.nix { nat-addr = my-nat-addr; })
  ];

  # ** Users
  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      hashedPassword = pass;

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" ];
    };

    users.root = {
      hashedPassword = pass;
    };

    mutableUsers = false;
  };

  # ** SSH
  # services.openssh.listenAddresses =
  #   [
  #     {
  #       addr = "192.168.56.101"; port = 22;
  #     }
  #   ];

  # ** Syncthing
  # services.syncthing.relay.enable = true;
  # services.syncthing.relay.port = ;
  # services.syncthing.relay.statusPort = ;
  # # [22 80]
  # networking.firewall.allowedTCPPorts = [];
}
