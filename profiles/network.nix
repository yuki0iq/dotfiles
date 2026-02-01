self: {
  lib,
  pkgs,
  ...
}: {
  imports = [
    self.profiles.chrony
    self.profiles.netcat-openbsd
    self.profiles.ssh-hardened
  ];

  environment.systemPackages = with pkgs; [
    curl
    iperf3
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

  services.openssh.enable = true;
}
