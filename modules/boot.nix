{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.boot.enable = lib.mkEnableOption "boot loader and tools";

  config = lib.mkIf config.meow.boot.enable {
    meow.kernel.enable = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    services.fwupd.enable = true;
  };
}
