{
  config,
  lib,
  pkgs,
  ...
}: {
  options.services.desktopManager.gnome.extensions = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule ({config, ...}: {
      options.extensionUuid = lib.mkOption {type = lib.types.str;};
      options.package = lib.mkPackageOption pkgs "extension" {default = pkgs.gnome-shell-extensions;};
      config.extensionUuid = lib.mkIf (config.package ? extensionUuid) (lib.mkDefault config.package.extensionUuid);
    }));
    description = "Declarative GNOME Shell Extension management";
    example = lib.literalExpression ''
      with pkgs.gnomeExtensions; [{package = light-style;}]
    '';
  };

  config = let
    cfg = config.services.desktopManager.gnome.extensions;
  in {
    environment.systemPackages = map (x: x.package) cfg;
    programs.dconf.profiles.user.databases = [
      {
        settings."org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = map (x: x.extensionUuid) cfg;
        };
      }
    ];
  };
}
