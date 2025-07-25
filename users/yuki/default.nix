# vim:et:ts=2:sw=2
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

  xdg.enable = true;
  home.preferXdgDirectories = true;

  xdg.configFile."xkb".source = ./xkb;
  xdg.configFile."sublime-text/Packages/User".source = ./sublime-text_Packages_User;
  xdg.configFile."ibus-anthy/engines.xml".text = let
    default = builtins.readFile "${pkgs.ibus-engines.anthy}/share/ibus-anthy/engine/default.xml";
  in
    builtins.replaceStrings ["<layout>jp</layout>"] ["<layout>default</layout>"] default;

  programs.bash = {
    enable = true;
    shellAliases = {
      downspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225";
      upspeed = "${pkgs.iperf3}/bin/iperf3 -c iperf3.moji.fr -p 5225 -R";
      cat = "${pkgs.bat}/bin/bat";
      ip = "ip -c=always";
      ls = "${pkgs.eza}/bin/eza --color=auto --hyperlink";
      diff = "diff --color=auto";
      psu = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd";
      psc = "ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd";
    };
    initExtra = ''
      PS1_MODE=minimal
      eval "$(${pkgs.statusline}/bin/statusline env)"
    '';
  };

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      {package = caffeine;}
      {package = light-style;}
    ];
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        edge-tiling = true;
        dynamic-workspaces = true;
      };
      "org/gnome/desktop/interface" = {
        font-name = "Adwaita Sans 11"; # FIXME(25.11): https://github.com/NixOS/nixpkgs/pull/401037 "System-ui 11";
        monospace-font-name = "Monospace 11";
        clock-show-weekday = true;
        clock-format = "24h";
        accent-color = "purple";
      };
      "org/gnome/desktop/a11y/interface" = {
        show-status-shapes = true;
      };
      "org/gnome/desktop/privacy" = {
        recent-files-max-age = 1;
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
        show-all-sources = true;
      };
      "org/gnome/desktop/peripherals/mouse" = {
        left-handed = false;
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab"];
      };
      "org/gnome/shell/extensions/caffeine" = {
        enable-fullscreen = false;
      };
      "desktop/ibus/general" = {
        use-system-keyboard-layout = true;
      };
    };
  };

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
        shinigami-eyes
        sponsorblock
        ublock-origin
        vimium
      ];
    };
  };

  home.packages = with pkgs; [
    (sublime4.overrideAttrs (self: super: {
      # XXX: Keep name here and in patch in sync with nixpkgs `primaryBinary`
      sublime_text = super.sublime_text.overrideAttrs (self: super: {
        postFixup =
          ''
            sed -i 's/\x80\x79\x05\x00\x0F\x94\xC2/\xC6\x41\x05\x01\xB2\x00\x90/' "$out/sublime_text"
          ''
          + super.postFixup;
      });
    }))
  ];
}
