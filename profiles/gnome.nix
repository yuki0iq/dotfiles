self: {
  lib,
  pkgs,
  ...
}: {
  imports = [self.profiles.graphical];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-console # ptyxis
    gnome-system-monitor # libgtop + mission-center
    gnome-tour
  ];

  environment.systemPackages = with pkgs; [
    gnome-themes-extra
    gnome-secrets
    libgtop
    mission-center
    ptyxis
    refine
  ];

  programs.thunderbird.enable = true;

  xdg.terminal-exec = {
    enable = true;
    settings.GNOME = ["org.gnome.Ptyxis.desktop"];
  };

  services.desktopManager.gnome.keybindings."<Super>Return" = {command = "${pkgs.ptyxis}/bin/ptyxis --new-window";};

  services.desktopManager.gnome.extensions = with pkgs.gnomeExtensions; [
    {package = caffeine;}
    {package = legacy-gtk3-theme-scheme-auto-switcher;}
    {package = light-style;}
    {package = vitals;}
  ];

  programs.dconf.profiles.user.enableUserDb = true;

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/a11y/interface".show-status-shapes = true;

        "org/gnome/desktop/input-sources".show-all-sources = true;

        "org/gnome/desktop/interface" = {
          font-name = "System-ui 11";
          monospace-font-name = "Monospace 11";
          clock-show-weekday = true;
          clock-format = "24h";
          gtk-enable-primary-paste = false;
          show-battery-percentage = true;
        };

        "org/gnome/desktop/privacy".recent-files-max-age = lib.gvariant.mkInt32 1;

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

        "org/gnome/Ptyxis" = {
          restore-session = false; # Useless without VTE integration
          default-profile-uuid = "default";
          profile-uuids = ["default"];
        };

        "org/gnome/Ptyxis/Profiles/default".palette = "gnome-high-contrast";

        "org/gnome/shell/app-switcher".current-workspace-only = false;

        "org/gnome/shell/extensions/caffeine".enable-fullscreen = false;

        "org/gnome/shell/extensions/vitals" = {
          hide-zeros = true;
          menu-centered = true;
          icon-style = lib.gvariant.mkInt32 1; # GNOME
          monitor-cmd = "${pkgs.mission-center}/bin/missioncenter";
          hot-sensors = ["_system_load_1m_"];
        };

        "desktop/ibus/general".use-system-keyboard-layout = true;
      };
    }
  ];

  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [
    self.packages.ibus-anthy
    table
    table-others
  ];
}
