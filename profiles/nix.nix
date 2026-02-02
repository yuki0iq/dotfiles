self: {pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    nix-output-monitor
    nix-tree
    npins
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
  system.forbiddenDependenciesRegexes = ["nix-2"];
  system.tools = {
    nixos-option.enable = false;
  };

  nix.channel.enable = false;
  nix.nixPath = ["/etc/nix-path"];
  environment.etc."nix-path/nixpkgs".source = self.pins.nixpkgs;

  nix.settings.use-xdg-base-directories = true;
}
