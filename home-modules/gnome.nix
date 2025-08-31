{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options = {
    meow.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to configure GNOME";
    };
  };

  config = lib.mkIf config.meow.gnome.enable {
    dconf.enable = true;

    dconf.settings = {
      "org/gnome/desktop/a11y/interface".show-status-shapes = true;

      "org/gnome/desktop/input-sources".show-all-sources = true;

      "org/gnome/desktop/interface" = {
        font-name = "System-ui 11";
        monospace-font-name = "Monospace 11";
        clock-show-weekday = true;
        clock-format = "24h";
        gtk-enable-primary-paste = false;
      };

      "org/gnome/desktop/privacy".recent-files-max-age = 1;

      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab"];
      };

      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        dynamic-workspaces = true;
        edge-tiling = true;
      };

      "org/gnome/Ptyxis".restore-session = false; # Useless without VTE integration

      "org/gnome/shell/app-switcher".current-workspace-only = false;

      "org/gnome/shell/extensions/caffeine".enable-fullscreen = false;

      "org/gnome/shell/extensions/vitals" = {
        hide-zeros = true;
        menu-centered = true;
        icon-style = 1; # GNOME
        monitor-cmd = "${pkgs.mission-center}/bin/missioncenter";
        hot-sensors = ["_system_load_1m_"];
      };
    };

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
