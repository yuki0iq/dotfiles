{
  config,
  lib,
  pkgs,
  ...
}: {
  options.services.desktopManager.gnome.keybindings = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
        };
        binding = lib.mkOption {type = lib.types.str;};
        command = lib.mkOption {type = lib.types.str;};
        enable-in-lockscreen = lib.mkEnableOption "this keybinding in lockscreen";
      };
    });
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

  config.programs.dconf.profiles.user.databases = let
    cfg = config.services.desktopManager.gnome.keybindings;
    removeNullName = lib.filterAttrs (k: v: k == "name" -> v != null);
    bindings = map removeNullName cfg;

    media-keys = "org/gnome/settings-daemon/plugins/media-keys";
    makeName = x: "${media-keys}/custom-keybindings/custom${toString x}";
    names = builtins.genList makeName (builtins.length bindings);

    bindingsList = {
      "${media-keys}".custom-keybindings = map (name: "/${name}/") names;
    };
    compiledBindings = builtins.listToAttrs (lib.lists.zipListsWith (name: value: {inherit name value;}) names bindings);
  in
    lib.mkIf (builtins.length cfg > 0) [
      {settings = bindingsList;}
      {settings = compiledBindings;}
    ];
}
