{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.gnome.enable = lib.mkEnableOption "configure GNOME";

  config = lib.mkIf config.meow.gnome.enable {
    dconf.enable = true;

    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        {package = caffeine;}
        {package = legacy-gtk3-theme-scheme-auto-switcher;}
        {package = light-style;}
        {package = vitals;}
      ];
    };
  };
}
