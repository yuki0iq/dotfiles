self: {...}: {
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface".accent-color = "teal";

        "org/gnome/desktop/background" = {
          picture-options = "zoom";
          picture-uri = "file://${self.packages.bg.yuuka}";
          picture-uri-dark = "file://${self.packages.bg.yuuka}";
        };
      };
    }
  ];
}
