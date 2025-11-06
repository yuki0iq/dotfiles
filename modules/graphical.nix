{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.graphical.enable = lib.mkEnableOption "graphical desktop";

  config = lib.mkIf config.meow.graphical.enable {
    meow.fonts.enable = true;

    services.xserver.enable = true;

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    console.useXkbConfig = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
    };

    i18n.inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        anthy
        table
        table-others
      ];
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
      vulkan-tools
      wl-clipboard
    ];
  };
}
