{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.programs.statusline.enable = lib.mkEnableOption "statusline PS1 for bash";

  config = lib.mkIf config.programs.statusline.enable {
    programs.bash.promptInit = ''
      PS1_MODE=minimal source <(${self.packages.statusline}/bin/statusline env)
    '';
    programs.bash.vteIntegration = false;
    services.openssh.settings.AcceptEnv = ["WORKGROUP_CHAIN"];
  };
}
