{pkg-s, ...}:
{
  imports = [
    ./lumos-server.nix
    ../../modules-system/xorg/xorg.nix
    ../../modules-system/firefox.nix
    ../../modules-system/imagemagick.nix

    ../../modules-system/portal.nix

    ../../modules-system/android.nix

    ../../modules-system/languagetool.nix

    ../../modules-system/obs.nix
  ];

  environment.systemPackages = with pkg-s; [
    stack

    # Needed for PDF jam
    # texliveMedium
    # ocamlPackages.cpdf

    nix-prefetch-git

    # gpaste-1
    lutris

    chromedriver

    htop

    git

    networkmanager
    networkmanagerapplet

    wget

    # Required to use cachix
    cachix

    # Needed for opengl?
    xorg.libxcb

    killall

    glslang
    shaderc

    SDL2
    # ydotool

    gcc
    zlib
  ];


  boot.kernel.sysctl = {
    # "net.ipv4.conf.all.forwarding" = 1;
    # "net.ipv4.conf.all.route_localnet" = 1;
    # "net.ipv4.conf.default.forwarding" = 1;

    # Allows the user to bind lower range addresses
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };


  users = {
    users.admin = {
      group = "users";
      isNormalUser = true;
      uid = 1000;
      password = "1";
      # hashedPassword =  "$6$emDF9qEWb4Q$VWmHX4lcEbMjC6xqr6h31QttnRUz.jMxpL1xFefXc5jiLOrSrobfrAy1lTxo4PqjCfG41sXoSVXEmveB.3E5S/";

      extraGroups = [ "wheel" "audio" "video" "usbmux" "networkmanager" "uinput"

                      # Printer
                      "lp"

                      # VM
                      "libvirt" "libvirtd" "kvm" "input" ];
    };
    users.root = {
      password = "1";
      # hashedPassword =  "$6$emDF9qEWb4Q$VWmHX4lcEbMjC6xqr6h31QttnRUz.jMxpL1xFefXc5jiLOrSrobfrAy1lTxo4PqjCfG41sXoSVXEmveB.3E5S/";
    };

    mutableUsers = false;
  };
}
