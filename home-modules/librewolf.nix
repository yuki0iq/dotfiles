{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  config.programs.librewolf = lib.mkIf config.programs.librewolf.enable {
    settings = {
    };
    profiles.default = {
      extensions.packages = with (pkgs.callPackage pins.rycee {}).firefox-addons; [
        consent-o-matic
        indie-wiki-buddy
        libredirect
        native-mathml
        seventv
        shinigami-eyes
        sponsorblock
        ublock-origin
        vimium
        youtube-no-translation
      ];
    };
  };
}
