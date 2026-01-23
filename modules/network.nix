{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.network.enable = lib.mkEnableOption "network tools and services" // {default = true;};

  options.environment.corePackages = lib.mkOption {apply = lib.subtractLists [pkgs.netcat];};

  config = lib.mkIf config.meow.network.enable {
    environment.systemPackages = with pkgs; [
      curl
      iperf3
      netcat-openbsd
      nmap
      rsync
      socat
      ssh-audit
    ];

    networking.networkmanager = {
      enable = true;
      settings.connectivity.uri = "http://nmcheck.gnome.org/check_network_status.txt";
    };

    networking.nftables.enable = true;

    programs.ssh.hardened = true;

    services.openssh = {
      enable = true;
      hardened = true;
    };
  };
}
