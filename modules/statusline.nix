{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  options.programs.statusline.enable = lib.mkEnableOption "statusline PS1 for bash";

  config = lib.mkIf config.programs.statusline.enable {
    programs.bash = {
      promptInit = ''
        PS1_MODE=minimal source <(${pkgs.callPackage pins.statusline {}}/bin/statusline env)
      '';

      vteIntegration = false;
    };

    services.openssh.settings.AcceptEnv = "WORKGROUP_CHAIN";
  };
}
