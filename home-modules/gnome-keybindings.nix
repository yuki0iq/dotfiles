{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
  makeKeybindings = bindings: let
    media-keys = "org/gnome/settings-daemon/plugins/media-keys";
    makeName = x: "${media-keys}/custom-keybindings/custom${toString x}";
    names = builtins.genList makeName (builtins.length bindings);
    bindingsList = {
      "${media-keys}".custom-keybindings = map (name: "/${name}/") names;
    };
    compiledBindings = builtins.listToAttrs (lib.lists.zipListsWith (name: value: {inherit name value;}) names bindings);
  in
    bindingsList // compiledBindings;
in {
  options = {
    meow.gnome.keybindings = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      description = "Custom keybindings for GNOME";
      example = lib.literalExpression ''
        [
          {
            binding = "<Super>Return";
            command = "${pkgs.firefox}/bin/firefox";
          }
        ]
      '';
    };
  };

  config.dconf.settings =
    lib.mkIf (builtins.length config.meow.gnome.keybindings > 0)
    (makeKeybindings config.meow.gnome.keybindings);
}
