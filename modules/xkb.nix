{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.xkb.enable = lib.mkEnableOption "xkb goodies";

  config = lib.mkIf config.meow.xkb.enable {
    environment.etc.xkb.source = ./_xkb;
  };
}
