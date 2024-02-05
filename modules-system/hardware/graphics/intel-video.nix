{pkg-s, lib, ...}:
{

  # boot.initrd.kernelModules = [ "amdgpu" ];

  # services.xserver.videoDriver = "amdgpu";
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # environment.variables.AMD_VULKAN_ICD = "RADV";

  boot.initrd.kernelModules = [ "i915" ];

  # Vaapi support
  # environment.variables.LIBVA_DRIVER_NAME = "i965";
  environment.variables.LIBVA_DRIVER_NAME = "iHD";

  environment.variables.VDPAU_DRIVER = "va_gl";

  # https://forums.debian.net/viewtopic.php?t=144681
  # https://github.com/i-rinat/libvdpau-va-gl
  # environment.variables.VDPAU_DRIVER = "va_gl";
  nixpkgs.config.packageOverrides = pkg-s: {
    vaapiIntel = pkg-s.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
  enable = true;
  extraPackages = with pkg-s; [
    intel-media-driver # LIBVA_DRIVER_NAME=iHD
    vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    vaapiVdpau

    # video acceleration
    libvdpau-va-gl
    # Vulkan

    # rocm-opencl-icd
    # rocm-opencl-runtime
    # amdvlk
    # driversi686Linux.amdvlk

    # OpenCL
    # rocm-opencl-icd
  ];

  extraPackages32 =  [
    # pkg-s.driversi686Linux.amdvlk
  ];
  };
}
