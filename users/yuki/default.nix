{
  config,
  lib,
  pkgs,
  ...
}: {
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  meow.graphical.enable = true;

  xdg.configFile."xkb".source = ./xkb;
  xdg.configFile."sublime-text/Packages/User".source = ./sublime-text_Packages_User;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
    };

    "org/gnome/desktop/background" = let
      yuuka = pkgs.fetchurl {
        urls = [
          "https://pixiv.net/img-original/img/2024/02/04/23/14/09/115770254_p0.jpg"
          "https://pixiv.ducks.party/img-original/img/2024/02/04/23/14/09/115770254_p0.jpg"
        ];
        hash = "sha256-jBVGOqZImknJ/gqSiplmCNII4skcvwxe8eE9mcxaVII=";
      };
    in {
      picture-options = "zoom";
      picture-uri = "file://${yuuka}";
      picture-uri-dark = "file://${yuuka}";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple ["xkb" "us+colemak_dh_yuki"])
        (lib.hm.gvariant.mkTuple ["xkb" "ru+rulemak_dh_yuki"])
      ];
      xkb-options = [
        "grp:caps_toggle"
        "grp_led:scroll" # XXX: What if only Caps lock led exists?
        "grp_led:caps"
      ];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      left-handed = false;
    };
  };

  meow.gnome.keybindings = [
    {
      binding = "<Super>Return";
      command = "${pkgs.ptyxis}/bin/ptyxis --new-window";
    }
    {
      binding = "<Super>F8";
      command = "${./keyboard-layout-group-switcher} qwerty";
    }
    {
      binding = "<Super>F9";
      command = "${./keyboard-layout-group-switcher} yuki";
    }
    {
      binding = "<Super>F10";
      command = "${./keyboard-layout-group-switcher} ibus";
    }
  ];

  programs.mpv = {
    enable = true;
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

  programs.librewolf = {
    enable = true;
    settings = {
    };
    profiles.default = {
      extensions.packages = with pkgs.rycee.firefox-addons; [
        indie-wiki-buddy
        libredirect
        native-mathml
        seventv
        shinigami-eyes
        sponsorblock
        ublock-origin
        vimium
      ];
    };
  };

  home.packages = with pkgs; [
    (sublime4.overrideAttrs (final: prev: {
      # XXX: Keep name here and in patch in sync with nixpkgs `primaryBinary`
      sublime_text = prev.sublime_text.overrideAttrs (final: prev: {
        # https://gist.github.com/JerryLokjianming/71dac05f27f8c96ad1c8941b88030451?permalink_comment_id=5590975
        postFixup =
          ''
            sed -i 's/\x0F\xB6\x51\x05\x83\xF2\x01/\xC6\x41\x05\x01\xB2\x00\x90/' "$out/sublime_text"
          ''
          + prev.postFixup;
      });
    }))
  ];
}
