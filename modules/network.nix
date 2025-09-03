{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  options.meow.network.enable = lib.mkEnableOption "network tools and services" // {default = true;};

  config = lib.mkIf config.meow.network.enable {
    environment.systemPackages = with pkgs; [
      curl
      iperf3
      nmap
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
