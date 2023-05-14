{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  inherit (lib) makeLibraryPath;
  libs = [
    pkg-config
    cabal-install
    haskell.compiler.ghc884
    zlib
    # ghcid
  ];
  weakLibs = [
    glfw
    xorg.libXext
    libGLU
    libGL
    xorg.libX11
    xorg.libXi
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libXcursor
    xorg.libXinerama

    # vulkan-extension-layer
    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-validation-layers
    SDL2
    zlib
    glslang
    shaderc

  ];
  libraryPath = "${makeLibraryPath weakLibs}";
in
pkgs.runCommand "shell" {
  buildInputs = libs ++ weakLibs;
  shellHook = ''
      export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${libraryPath}"
      export LIBRARY_PATH="${libraryPath}"
      export VK_LOADER_DEBUG="all"
    '';
} ""
