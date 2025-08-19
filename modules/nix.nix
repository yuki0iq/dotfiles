# vim:et:ts=2:sw=2
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

    nix.nixPath = [
      "nixpkgs=${pins.nixpkgs}"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    nix.settings.use-xdg-base-directories = true;
  };
}
