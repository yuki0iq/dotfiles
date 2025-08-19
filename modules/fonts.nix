{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  options = {
    meow.fonts = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable font configuration";
    };
  };

  config = lib.mkIf config.meow.fonts {
    fonts = {
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
        (fantasque-sans-mono.overrideAttrs (self: super: {
          installPhase =
            builtins.replaceStrings
            ["OTF" "otf" "opentype"]
            ["TTF" "ttf" "truetype"]
            super.installPhase;
        }))
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        texlivePackages.euler-math
        twitter-color-emoji

        # Fallback fonts
        liberation_ttf  # Nice Arial/Times New Roman/Courier New replacement
        unifont
      ];
    };
  };
}
