{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options.meow.basics.enable = lib.mkEnableOption "basic debugging and maintenance tools" // {default = true;};

  config = lib.mkIf config.meow.basics.enable {
    environment.shellAliases = {
      downspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225";
      upspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225 -R";
      cat = "${pkgs.bat}/bin/bat";
      ip = "ip -c=always";
      ls = "${pkgs.eza}/bin/eza --color=auto --hyperlink";
      diff = "diff --color=auto";
      psu = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd";
      psc = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd";
    };

    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix

      bat
      bc
      dua
      eza
      libqalculate
      moreutils
      ripgrep

      config.boot.kernelPackages.cpupower
      config.boot.kernelPackages.perf
      lm_sensors
      pciutils
      usbutils

      file
      lsof
      strace
    ];

    programs.bash = {
      completion.enable = true;

      promptInit = ''
        PS1_MODE=minimal
        eval "$(${pkgs.statusline}/bin/statusline env)"
      '';

      vteIntegration = false;
    };

    programs.command-not-found = {
      enable = true;
      dbPath = "${pins.nixpkgs}/programs.sqlite";
    };

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

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    programs.tmux.enable = true;
  };
}
