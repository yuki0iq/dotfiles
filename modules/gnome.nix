{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.services.desktopManager.gnome.enable {
    environment.gnome.excludePackages = with pkgs; [
      gnome-console # ptyxis
      gnome-system-monitor # libgtop + mission-center
      gnome-tour
    ];

    programs.thunderbird.enable = true;

    xdg.terminal-exec = {
      enable = true;
      settings = {
        GNOME = [
          "org.gnome.Ptyxis.desktop"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      gnome-themes-extra
      gnome-secrets
      libgtop
      mission-center
      ptyxis
      refine
    ];
  };
}
