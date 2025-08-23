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
  };
}
