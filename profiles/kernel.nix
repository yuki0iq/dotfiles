self: {
  config,
  pkgs,
  ...
}: {
  # TODO: Remove explicit setting when 6.18 LTS becomes the default kernel package set
  boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;

  boot.tmp.useTmpfs = true;

  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.cpupower
    lm_sensors
    pciutils
    perf
    usbutils
  ];

  zramSwap.enable = true;
}
