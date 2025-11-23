{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  options.meow.basics.enable = lib.mkEnableOption "basic debugging and maintenance tools" // {default = true;};

  config = lib.mkIf config.meow.basics.enable {
    environment.defaultPackages = lib.mkForce [];

    environment.systemPackages = with pkgs; [
      bc
      dua
      file
      libqalculate
      lsof
      strace
    ];

    programs.direnv.enable = true;

    programs.git = {
      enable = true;
      autosign = true;
      lfs.enable = true;
      short-aliases = true;

      config = {
        user = {
          name = "Yuki Sireneva";
          email = "yuki.utk8g@gmail.com";
        };
      };
    };

    programs.htop.enable = true;

    programs.vim = {
      enable = true;
      defaultEditor = true;
    };

    programs.nix-ld.enable = true;

    programs.tmux.enable = true;
  };
}
