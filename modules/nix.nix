{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  imports = [
    (import "${pins.lix-nixos-module}/module.nix" {lix = null;})
  ];

  options.meow.nix.enable = lib.mkEnableOption "nix configuration and tools" // {default = true;};

  config = lib.mkIf config.meow.nix.enable {
    environment.systemPackages = with pkgs; [
      alejandra
      nix-output-monitor
      (pkgs.callPackage pins.npins {})
    ];

    nix.channel.enable = false;

    nix.nixPath = ["nixpkgs=${pins.nixpkgs}"];

    nix.settings.use-xdg-base-directories = true;
  };
}
