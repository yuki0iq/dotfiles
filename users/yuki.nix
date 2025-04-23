# vim:et:ts=2:sw=2
{
  config,
  pkgs,
  ...
}: {
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  xdg.enable = true;
  home.preferXdgDirectories = true;

  xdg.configFile."xkb".source = ./yuki/xkb;

  programs.bash = {
    enable = true;
    shellAliases = {
      downspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225";
      upspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225 -R";
      cat = "${pkgs.bat}/bin/bat";
      ip = "ip -c=always";
      ls = "${pkgs.eza}/bin/eza --color=auto --hyperlink";
      diff = "diff --color=auto";
      psu = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd";
      psc = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd";
    };
    initExtra = ''
      case $TERM in
          linux|tmux-*)
              PS1_MODE=text
              ;;
          *)
              PS1_MODE=minimal
              ;;
      esac
      export PS1_MODE

      if command -v statusline >/dev/null; then
          # statusline does the job for bash
          export MAILCHECK=-1
          eval "$(statusline env)"
      fi
    '';
  };

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      {package = caffeine;}
      {package = light-style;}
    ];
  };
}
