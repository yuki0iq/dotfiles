# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  options = {
    meow.network = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable network tools and services";
    };
  };

  config = lib.mkIf config.meow.network {
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
