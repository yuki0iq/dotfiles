{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options = {
    meow.anthy = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to configure anthy";
    };
  };

  config = lib.mkIf config.meow.anthy {
    dconf.settings."desktop/ibus/general".use-system-keyboard-layout = true;

    xdg.configFile."ibus-anthy/engines.xml".text = let
      default = builtins.readFile "${pkgs.ibus-engines.anthy}/share/ibus-anthy/engine/default.xml";
    in
      builtins.replaceStrings ["<layout>jp</layout>"] ["<layout>default</layout>"] default;
  };
}
