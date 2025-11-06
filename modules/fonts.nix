{
  config,
  lib,
  pkgs,
  ...
}: {
  options.meow.fonts.enable = lib.mkEnableOption "font configuration";

  config.fonts = lib.mkIf config.meow.fonts.enable {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
        monospace = ["Fantasque Sans Mono"];
      };
    };

    # Most NixOS default fonts are either
    # - redundant with this config (DejaVu over Noto),
    # - useless (freefont), or
    # - awful (gyre-fonts does not support Cyrillic script)
    enableDefaultPackages = false;

    packages = with pkgs; [
      (fantasque-sans-mono.overrideAttrs (final: prev: {
        installPhase =
          builtins.replaceStrings
          ["OTF" "otf" "opentype"]
          ["TTF" "ttf" "truetype"]
          prev.installPhase;
      }))
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      texlivePackages.euler-math
      twitter-color-emoji

      # Fallback fonts
      liberation_ttf # Nice Arial/Times New Roman/Courier New replacement
      unifont
    ];
  };
}
