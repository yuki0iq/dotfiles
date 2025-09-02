{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  options = {
    meow.nix = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable nix configuration and tools";
    };
  };

  config = lib.mkIf config.meow.nix {
    environment.systemPackages = with pkgs; [
      alejandra
      nix-output-monitor
      npins
    ];

    nix.channel.enable = false;

    nix.nixPath = ["nixpkgs=${pins.nixpkgs}"];

    nix.settings.use-xdg-base-directories = true;
  };
}
