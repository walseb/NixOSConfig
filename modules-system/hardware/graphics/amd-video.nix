{pkgs, ...}:
{

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDriver = "amdgpu";
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs; [
    # rocm-opencl-icd
    # rocm-opencl-runtime
    # amdvlk
    # driversi686Linux.amdvlk
  ];
}
