{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  options.meow.shell.enable = lib.mkEnableOption "shell configuration" // {default = true;};

  config = lib.mkIf config.meow.shell.enable {
    environment.shellAliases = {
      downspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225 -R";
      upspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225";
      cat = "${pkgs.bat}/bin/bat";
      ip = "ip -c=always";
      ls = "${pkgs.eza}/bin/eza --color=auto --hyperlink";
      diff = "diff --color=auto";
      psu = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd";
      psc = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd";
      nix-build = "nix-build --log-format multiline-with-logs";
      nix-shell = "nix-shell --log-format multiline-with-logs";
      nixos-rebuild = "nixos-rebuild --log-format multiline-with-logs";
    };

    environment.systemPackages = with pkgs; [
      bat
      eza
      jq
      moreutils
      ripgrep
    ];

    programs.bash.completion.enable = true;

    programs.command-not-found = {
      enable = true;
      dbPath = "${pins.nixpkgs}/programs.sqlite";
    };

    programs.statusline.enable = true;
  };
}
