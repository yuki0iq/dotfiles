{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options.meow.anthy.enable = lib.mkEnableOption "anthy configuration";

  config = lib.mkIf config.meow.anthy.enable {
    dconf.settings."desktop/ibus/general".use-system-keyboard-layout = true;

    xdg.configFile."ibus-anthy/engines.xml".text = let
      default = builtins.readFile "${pkgs.ibus-engines.anthy}/share/ibus-anthy/engine/default.xml";
    in
      builtins.replaceStrings ["<layout>jp</layout>"] ["<layout>default</layout>"] default;
  };
}
