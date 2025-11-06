{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.kernel.enable = lib.mkEnableOption "linux kernel and tools";

  config = lib.mkIf config.meow.kernel.enable {
    boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;

    environment.systemPackages = with pkgs; [
      config.boot.kernelPackages.cpupower
      lm_sensors
      pciutils
      perf
      usbutils
    ];
  };
}
