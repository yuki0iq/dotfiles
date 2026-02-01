self: {
  config,
  lib,
  ...
}: {
  services.timesyncd.enable = false;
  services.chrony.enable = true;

  # work around https://github.com/NixOS/nixpkgs/issues/445035
  systemd.tmpfiles.rules = lib.mkAfter [
    "z ${config.services.chrony.directory}/chrony.keys 0640 root chrony - -"
  ];
}
