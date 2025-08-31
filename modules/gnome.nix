{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  config = lib.mkIf config.services.desktopManager.gnome.enable {
    environment.gnome.excludePackages = with pkgs; [
      geary # thunderbird
      gnome-console # ptyxis
      gnome-system-monitor # libgtop + mission-center
      gnome-tour
      evince # papers
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
      papers
      ptyxis
      refine
    ];
  };
}
