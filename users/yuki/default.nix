{
  config,
  lib,
  pkgs,
  self,
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

  home.preferXdgDirectories = true;
  xdg.enable = true;

  # XXX: Source hm-session-vars.sh in user shells even if bash is unmanaged by home-manager
  programs.bash = {
    enable = true;
    package = null;
  };

  manual.html.enable = true;
  manual.manpages.enable = true;
  # TODO: Readd when https://github.com/NixOS/nixpkgs/pull/414076 for h-m lands
  # programs.man.generateCaches = true;

  programs.librewolf = {
    enable = true;
    settings = {
    };
    profiles.default = {
      extensions.packages = with self.packages.rycee-nur.firefox-addons; [
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

  xdg.configFile."sublime-text/Packages/User".source = ./sublime-text_Packages_User;
}
