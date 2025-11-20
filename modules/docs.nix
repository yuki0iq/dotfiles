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

    # TODO: Readd when https://github.com/NixOS/nixpkgs/pull/414076 lands
    # documentation.man.generateCaches = true;
  };
}
