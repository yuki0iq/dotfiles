{
  config,
  lib,
  pkgs,
  ...
}: {
  config.programs.mpv = lib.mkIf config.programs.mpv.enable {
    config = {
      hdr-compute-peak = false;
      profile = "fast";
      sub-auto = "fuzzy";
      audio-file-auto = "fuzzy";
      cache = true;
      demuxer-max-bytes = "512MiB";
    };
    scripts = with pkgs.mpvScripts; [mpris];
  };
}
