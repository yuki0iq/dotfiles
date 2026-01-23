{
  config,
  lib,
  pkgs,
  ...
}: {
  options.programs.mpv = {
    enable = lib.mkEnableOption "mpv";
    scripts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      example = lib.literalExpression "with pkgs.mpvScripts; [mpris]";
    };
    config = lib.mkOption {
      type = lib.types.nullOr lib.types.lines;
      description = "contents of /etc/mpv/mpv.conf";
      default = null;
    };
  };

  config = lib.mkIf config.programs.mpv.enable {
    environment.systemPackages = with pkgs; [
      (mpv.override {
        mpv-unwrapped = mpv-unwrapped.overrideAttrs (final: prev: {
          # XXX: Remove when mpv from nixpkgs gains native support for /etc as system config dir
          mesonFlags = prev.mesonFlags ++ [(lib.mesonOption "sysconfdir" "/etc")];
        });
        scripts = config.programs.mpv.scripts;
      })
    ];

    environment.etc."mpv/mpv.conf".text = config.programs.mpv.config;
  };
}
