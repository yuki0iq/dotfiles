# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
    environment.gnome.excludePackages = with pkgs; [
      gnome-console # Replace with ptyxis
    ];

    xdg.terminal-exec = {
      enable = true;
      settings = {
        GNOME = [
          "org.gnome.Ptyxis.desktop"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      gnome-secrets
      ptyxis
      refine
    ];
  };
}
