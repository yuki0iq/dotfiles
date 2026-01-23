{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.graphical.enable = lib.mkEnableOption "graphical desktop";

  config = lib.mkIf config.meow.graphical.enable {
    meow.fonts.enable = true;
    meow.xkb.enable = true;

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    console.useXkbConfig = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
    };

    services.printing.enable = false;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    xdg.terminal-exec.package = pkgs.xdg-terminal-exec-mkhl;

    programs.obs-studio.enable = true;

    programs.wireshark.package = pkgs.wireshark;

    environment.systemPackages = with pkgs; [
      mesa-demos
      (mpv.override {
        mpv-unwrapped = mpv-unwrapped.overrideAttrs (final: prev: {
          # XXX: Remove when mpv from nixpkgs gains native support for /etc as system config dir
          mesonFlags = prev.mesonFlags ++ [(lib.mesonOption "sysconfdir" "/etc")];
        });
        scripts = with pkgs.mpvScripts; [mpris];
      })
      vulkan-tools
      waypipe
      wl-clipboard
      xwayland-satellite # waypipe dep
    ];

    environment.etc."mpv/mpv.conf".text = ''
      hdr-compute-peak=no
      profile=fast
      sub-auto=fuzzy
      audio-file-auto=fuzzy
      cache=yes
      demuxer-max-bytes=512MiB
    '';
  };
}
