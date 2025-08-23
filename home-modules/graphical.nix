{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  options = {
    meow.graphical = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable graphical desktop";
    };
  };

  config = {
    meow.anthy = lib.mkDefault true;
    meow.gnome.enable = lib.mkDefault true;
  };
}
