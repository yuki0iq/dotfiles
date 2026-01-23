{
  config,
  lib,
  pkgs,
  pins,
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
    ((prismlauncher.override {
        prismlauncher-unwrapped = prismlauncher-unwrapped.overrideAttrs (final: prev: {
          pname = "fjordlauncher-unwrapped";
          version = "10.0-unstable-2026-01-08";
          src = prev.src.override {
            owner = "unmojang";
            repo = "FjordLauncher";
            tag = null;
            rev = "31d3cc63669e60509c965cff5385ac2711691c4f";
            hash = "sha256-N6eGWxcNvKqUyFzHinOLV9NosH63eLMfCT8LAWHPTtI=";
          };
          patches = (prev.patches or []) ++ [../../patches/fjordlauncher/0001-Make-FjordLauncher-DRM-free.patch];
          buildInputs = prev.buildInputs ++ [kdePackages.qt5compat]; # XXX: This isn't mentioned anywhere, hacky
        });
      }).overrideAttrs (final: prev: {
        pname = "fjordlauncher";
        name = "${final.pname}-${final.version}"; # XXX: otherwise the derivation is named prismlauncher-...
        qtWrapperArgs = map (builtins.replaceStrings ["PRISMLAUNCHER_JAVA_PATHS"] ["FJORDLAUNCHER_JAVA_PATHS"]) prev.qtWrapperArgs;
        meta = prev.meta // {mainProgram = "fjordlauncher";};
      }))
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
    (callPackage pins.yukigram {})

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

        "org/gnome/desktop/peripherals/mouse".left-handed = false;
      };
    }
  ];

  services.desktopManager.gnome.keybindings = [
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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "sublimetext4"
    ];
  # XXX: https://github.com/NixOS/nixpkgs/issues/239615
  # Blocked on upstream: https://github.com/sublimehq/sublime_text/issues/5984
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
