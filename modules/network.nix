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

    programs.ssh.hardened = true;

    programs.wireshark.enable = true;

    services.openssh = {
      enable = true;
      hardened = true;
    };
  };
}
