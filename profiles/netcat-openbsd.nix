self: {
  lib,
  pkgs,
  ...
}: {
  options.environment.corePackages = lib.mkOption {apply = lib.subtractLists [pkgs.netcat];};
  config.environment.systemPackages = with pkgs; [netcat-openbsd];
}
