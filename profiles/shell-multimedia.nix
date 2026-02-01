self: {pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    imagemagick
    exiftool
    ffmpeg
    libjxl # cjxl
  ];
}
