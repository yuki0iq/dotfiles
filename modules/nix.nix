{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.meow.nix.enable = lib.mkEnableOption "nix configuration and tools" // {default = true;};

  config = lib.mkIf config.meow.nix.enable {
    environment.systemPackages = with pkgs; [
      alejandra
      nix-output-monitor
      nix-tree
      npins
    ];

    nix.channel.enable = false;

    nix.package = pkgs.lixPackageSets.latest.lix;

    nix.nixPath = [
      "nixpkgs=${self.pins.nixpkgs}"
    ];

    nix.settings.use-xdg-base-directories = true;

    system.forbiddenDependenciesRegexes = ["nix-2"];

    system.tools = {
      nixos-option.enable = false;
    };
  };
}
