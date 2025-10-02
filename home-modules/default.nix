{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  imports = [
    ./anthy.nix
    ./gnome.nix
    ./gnome-keybindings.nix
    ./graphical.nix
  ];

  config = {
    home.preferXdgDirectories = lib.mkDefault true;
    xdg.enable = lib.mkDefault true;

    manual.html.enable = true;
    manual.manpages.enable = true;
    programs.man.generateCaches = true;

    # XXX: Source hm-session-vars.sh in user shells even if bash is unmanaged by home-manager
    programs.bash = {
      enable = true;
      package = null;
    };
  };
}
