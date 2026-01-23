{
  config,
  lib,
  ...
}: {
  options.meow.pipewire.enable = lib.mkEnableOption "pipewire";

  config = lib.mkIf config.meow.pipewire.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
