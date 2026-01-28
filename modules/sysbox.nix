self: {
  config,
  lib,
  pkgs,
  ...
}: {
  options.virtualisation.docker.enableSysbox = lib.mkEnableOption "Sysbox Docker runtime";

  config = lib.mkIf config.virtualisation.docker.enableSysbox {
    virtualisation.docker.daemon.settings.runtimes.sysbox-runc.path = "${self.packages.sysbox}/bin/sysbox-runc";
    systemd.packages = [self.packages.sysbox];
    systemd.services.sysbox.wantedBy = ["multi-user.target"];
    systemd.services.sysbox-mgr.path = with pkgs; [rsync kmod iptables];
    systemd.services.sysbox-fs.path = with pkgs; [fuse];
  };
}
