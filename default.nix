let
  bare_pins = import ./npins;
  pkgs = import bare_pins.nixpkgs {};
  pins = builtins.mapAttrs (name: pinned: pinned {inherit pkgs;}) bare_pins;

  lib = pkgs.lib;
  evalConfig = import "${pins.nixpkgs}/nixos/lib/eval-config.nix";
  nixosSystem = host: evalConfig {
    specialArgs = {
      inherit pins;
    };

    modules = [
      ./modules
      ./hosts/${host}
    ];
  };
in
{
  nixosConfigurations = lib.flip lib.genAttrs nixosSystem [
    "yuuka"
  ];
}
