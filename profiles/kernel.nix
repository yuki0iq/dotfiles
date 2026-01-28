self: {
  config,
  pkgs,
  ...
}: {
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
