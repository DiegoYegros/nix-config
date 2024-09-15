{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nouveau" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.driSupport32Bit = true;
}

