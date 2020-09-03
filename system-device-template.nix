let
  # Generate using mkpasswd -m sha-512
  pass = null;
  my-nat-addr = null;
in
{
  imports = [
    # ./system-hw-configs/x200-libreboot.nix
    # ./system-hw-configs/home-vm.nix
    # ./system-hw-configs/vps.nix
    # ./system-hw-configs/ideapad.nix

    # ./system-modules/network/wireguard-server.nix
    # (import ./system-modules/network/wireguard-client.nix { nat-addr = my-nat-addr; })
  ];

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

  # services.syncthing.relay.enable = true;
  # services.syncthing.relay.port = ;
  # services.syncthing.relay.statusPort = ;
  # # [22 80]
  # networking.firewall.allowedTCPPorts = [];
}
