{
  config,
  lib,
  ...
}: {
  options.meow.colemak-dh.enable = lib.mkEnableOption "colemak-dh layout";

  config = lib.mkIf config.meow.colemak-dh.enable {
    console.useXkbConfig = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
    };
    environment.etc.xkb.source = ./_xkb;
  };
}
