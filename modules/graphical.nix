# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options = {
    meow.graphical = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable graphical desktop";
    };
  };

  config = lib.mkIf config.meow.graphical {
    meow.fonts = lib.mkDefault true;

    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

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
        # FIXME(25.05): https://nixpk.gs/pr-tracker.html?pr=420679
        # table
        # table-others
      ];
    };

    services.printing.enable = false;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
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
