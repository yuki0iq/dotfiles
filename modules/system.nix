# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options = {
    meow.system = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to configure system";
    };
  };

  config = lib.mkIf config.meow.system {
    boot.tmp.useTmpfs = true;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_MEASUREMENT = "C.UTF-8";
      LC_PAPER = "C.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };

    networking.networkmanager.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # FIXME(25.11): Enable by default
    system.rebuild.enableNg = true;

    time.timeZone = "Europe/Moscow";

    zramSwap.enable = true;
  };
}
