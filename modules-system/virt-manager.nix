{pkg-s, ...}:
{
  programs.virt-manager.enable = true;

  boot.kernelModules = [ "kvm-intel" "vfio-pci" ];
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt"];

  programs.dconf.enable = true;

  environment.systemPackages = with pkg-s; [
    virt-viewer
    spice 
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
  ];

  networking.nat = {
    enable = true;
    internalInterfaces = [ "virbr0" ];
    # externalInterface = "eno1";
    # forwardPorts = [
    #   {
    #     sourcePort = 3389;
    #     proto = "tcp";
    #     destination = "192.168.122.81:3389";
    #   }
    #   {
    #     sourcePort = 3389;
    #     proto = "udp";
    #     destination = "192.168.122.81:3389";
    #   }
    # ];
  };
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkg-s.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}


  # programs = {
  #   dconf.settings = {
  #     "org/virt-manager/virt-manager/connections" = {
  #       autoconnect = ["qemu:///system"];
  #       uris = ["qemu:///system"];
  #     };
  #   };
  # };
