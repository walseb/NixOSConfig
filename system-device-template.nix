# * Config
let
  # Generate using ~mkpasswd -m sha-512~ contained in package ~mkpasswd~
  pass = null;
  # Server doesn't need this. Check ./nixos-private-config/vpn-clients.nix
  # my-nat-addr = null;
in
{
  # ** Imports
  imports = [
    # ./hw-configs/x200-libreboot.nix
    # ./hw-configs/vbox.nix
    # ./hw-configs/vps.nix
    # ./hw-configs/ideapad.nix
    # ./hw-configs/nuc.nix

    # ./modules-system/network/sshd.nix
    # ./modules-system/network/sshd-xorg.nix

    # ./modules-system/network/wireguard-server.nix
    # (import ./modules-system/network/wireguard-client.nix { nat-addr = my-nat-addr; })
  ];

  networking.hostName = "nixos";

  # ** Users
  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      # password = "";
      hashedPassword = pass;

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" "uinput" ];
    };

    users.root = {
      # password = "";
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
