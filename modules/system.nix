{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options.meow.system.enable = lib.mkEnableOption "essential system configuration" // {default = true;};

  config = lib.mkIf config.meow.system.enable {
    boot.tmp.useTmpfs = true;

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_MEASUREMENT = "C.UTF-8";
      LC_PAPER = "C.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };

    networking.networkmanager = {
      enable = true;
      settings = {
        connectivity.uri = "http://nmcheck.gnome.org/check_network_status.txt";
      };
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    time.timeZone = "Europe/Moscow";

    zramSwap.enable = true;
  };
}
