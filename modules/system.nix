{
  config,
  lib,
  ...
}: {
  options.meow.system.enable = lib.mkEnableOption "essential system configuration" // {default = true;};

  config = lib.mkIf config.meow.system.enable {
    boot.tmp.useTmpfs = true;

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_MEASUREMENT = "C.UTF-8";
      LC_PAPER = "C.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
    i18n.extraLocales = "all";

    networking.networkmanager = {
      enable = true;
      settings = {
        connectivity.uri = "http://nmcheck.gnome.org/check_network_status.txt";
      };
    };

    networking.nftables.enable = true;

    time.timeZone = "Europe/Moscow";

    zramSwap.enable = true;
  };
}
