{
  config,
  lib,
  ...
}: {
  options.meow.graphical.enable = lib.mkEnableOption "graphical desktop";

  config = lib.mkIf config.meow.graphical.enable {
    meow.anthy.enable = lib.mkDefault true;
    meow.gnome.enable = lib.mkDefault true;
  };
}
