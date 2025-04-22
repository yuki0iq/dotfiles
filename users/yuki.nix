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

  programs.bash.enable = true;

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      {package = caffeine;}
      {package = light-style;}
    ];
  };
}
