self: {lib, ...}: {
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
  environment.etc.xkb.source = ./_xkb;

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/input-sources".sources = [
        (lib.gvariant.mkTuple ["xkb" "us_yuki+colemak_dh"])
        (lib.gvariant.mkTuple ["xkb" "ru_yuki+rulemak_dh"])
      ];
    }
  ];

  services.desktopManager.gnome.keybindings = {
    "<Super>F8" = {command = "${./keyboard-layout-group-switcher} qwerty";};
    "<Super>F9" = {command = "${./keyboard-layout-group-switcher} yuki";};
    "<Super>F10" = {command = "${./keyboard-layout-group-switcher} ibus";};
  };
}
