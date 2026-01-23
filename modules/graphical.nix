{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.graphical.enable = lib.mkEnableOption "graphical desktop";

  config = lib.mkIf config.meow.graphical.enable {
    meow.colemak-dh.enable = true;
    meow.fonts.enable = true;
    meow.pipewire.enable = true;

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    xdg.terminal-exec.package = pkgs.xdg-terminal-exec-mkhl;

    environment.systemPackages = with pkgs; [
      mesa-demos
      vulkan-tools
      waypipe
      wl-clipboard
      xwayland-satellite # waypipe dep
    ];

    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [mpris];
      config = ''
        hdr-compute-peak=no
        profile=fast
        sub-auto=fuzzy
        audio-file-auto=fuzzy
        cache=yes
        demuxer-max-bytes=512MiB
      '';
    };
  };
}
