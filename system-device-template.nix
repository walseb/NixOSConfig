{
  imports = [
    # ./system-hw-configs/x200-libreboot.nix
    # ./system-hw-configs/home-vm.nix
    # ./system-hw-configs/vps.nix
    # ./system-hw-configs/ideapad.nix
  ];

  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      # password = "";
      # hashedPassword = "";

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" ];
    };
    mutableUsers = false;
  };

  # services.syncthing.relay.enable = true;
  # services.syncthing.relay.port = ;
  # services.syncthing.relay.statusPort = ;
  # # [22 80]
  # networking.firewall.allowedTCPPorts = [];
}
