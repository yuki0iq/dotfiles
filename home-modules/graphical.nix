{
  config,
  lib,
  ...
}: {
  options.meow.graphical.enable = lib.mkEnableOption "graphical desktop";

  config = lib.mkIf config.meow.graphical.enable {
    meow.anthy.enable = true;
    meow.gnome.enable = true;

    programs.librewolf.enable = true;
    programs.mpv.enable = true;
  };
}
