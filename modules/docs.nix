{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.meow.basics.enable {
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];

    documentation.man.generateCaches = true;
  };
}
