{ pkg-s, ...}:
{
  environment.systemPackages = with pkg-s; [
    android-studio
    qemu_kvm
  ];

  boot.kernelModules = ["kvm-intel"];

  # virtualisation.qemu.guestAgent.enable = true;
  # services.qemuGuest.enable = true;
  # virtualisation.libvirtd.qemu.ovmf.enable = true;
  virtualisation.kvmgt.enable = true;

  # ADB
  programs.adb.enable = true;
  users.users.admin.extraGroups = ["adbusers"];
}
