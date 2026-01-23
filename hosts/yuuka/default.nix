{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "yuuka";

  virtualisation.docker = {
    enable = true;
    enableSysbox = true;
  };

  programs.obs-studio.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.yuki = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker" "wireshark"];
    openssh.authorizedKeys.keyFiles = [../../users/yuki/authorized_keys];
  };

  users.users.test = {
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = config.users.users.yuki.openssh.authorizedKeys.keyFiles;
  };

  home-manager.users.yuki = import ../../users/yuki;

  environment.systemPackages = with pkgs; [
    fractal
    self.packages.fjordlauncher
    self.packages.sublime4
    self.packages.yukigram

    gcc
    gef
    python3
    rustup
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface".accent-color = "teal";

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
            (lib.gvariant.mkTuple ["xkb" "us_yuki+colemak_dh"])
            (lib.gvariant.mkTuple ["xkb" "ru_yuki+rulemak_dh"])
          ];
          xkb-options = ["grp:caps_toggle" "grp_led:scroll" "compose:rctrl" "lv3:ralt_switch" "lv3:rwin_switch" "lv5:menu_switch"];
        };
      };

      # XXX: Prevent gnome-shell from resetting to wrong xkb options in case they are reset to default
      locks = ["/org/gnome/desktop/input-sources/xkb-options"];
    }
  ];

  services.desktopManager.gnome.keybindings = {
    "<Super>F8" = {command = "${./keyboard-layout-group-switcher} qwerty";};
    "<Super>F9" = {command = "${./keyboard-layout-group-switcher} yuki";};
    "<Super>F10" = {command = "${./keyboard-layout-group-switcher} ibus";};
  };

  meow.boot.enable = true;
  meow.graphical.enable = true;

  services.printing = {
    enable = lib.mkForce true;
    drivers = [pkgs.hplip];
  };
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplip];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
