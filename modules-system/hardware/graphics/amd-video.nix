{pkg-s, ...}:
{

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDriver = "amdgpu";
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.variables.AMD_VULKAN_ICD = "RADV";

  # Vaapi support
  environment.variables.LIBVA_DRIVER_NAME = "radeonsi";

  # https://forums.debian.net/viewtopic.php?t=144681
  # https://github.com/i-rinat/libvdpau-va-gl
  # environment.variables.VDPAU_DRIVER = "va_gl";

  hardware.opengl = {
    enable = true;
    extraPackages = with pkg-s; [
      # Vulkan
      amdvlk
      # rocm-opencl-icd
      # rocm-opencl-runtime
      # amdvlk
      # driversi686Linux.amdvlk

      # OpenCL
      rocm-opencl-icd

      # video acceleration
      libvdpau-va-gl
    ];

    extraPackages32 =  [
      pkg-s.driversi686Linux.amdvlk
    ];
  };
}
