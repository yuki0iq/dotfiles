{lib, ...}: {
  imports = [
    ./anthy.nix
    ./gnome.nix
    ./gnome-keybindings.nix
    ./graphical.nix
    ./librewolf.nix
    ./mpv.nix
  ];

  config = {
    home.preferXdgDirectories = true;
    xdg.enable = true;

    manual.html.enable = true;
    manual.manpages.enable = true;
    # TODO: Readd when https://github.com/NixOS/nixpkgs/pull/414076 for h-m lands
    # programs.man.generateCaches = true;

    # XXX: Source hm-session-vars.sh in user shells even if bash is unmanaged by home-manager
    programs.bash = {
      enable = true;
      package = null;
    };
  };
}
