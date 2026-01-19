{
  config,
  lib,
  pkgs,
  pins,
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
        (lib.hm.gvariant.mkTuple ["xkb" "us_yuki+colemak_dh"])
        (lib.hm.gvariant.mkTuple ["xkb" "ru_yuki+rulemak_dh"])
      ];
      xkb-options = [
        "grp:caps_toggle"
        "grp_led:scroll" # XXX: What if only Caps lock led exists?
        "grp_led:caps"
        "compose:rctrl"
        "lv3:ralt_switch"
        "lv3:rwin_switch"
        "lv5:menu_switch"
      ];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      left-handed = false;
    };
  };

  meow.gnome.keybindings = [
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
}
