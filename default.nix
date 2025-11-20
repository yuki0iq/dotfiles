let
  bare_pins = import ./npins;
  pkgs = import bare_pins.nixpkgs {};
  pins = builtins.mapAttrs (name: pinned: pinned {inherit pkgs;}) bare_pins;

  lib = pkgs.lib;
  readDir' = dir: lib.mapAttrsToList (name: _: lib.path.append dir name) (builtins.readDir dir);
  nixosSystem = name:
    (import "${pins.nixpkgs}/nixos/lib/eval-config.nix") {
      specialArgs = {inherit pins;};
      modules = (readDir' ./modules) ++ [./hosts/${name}];
    };
in {
  nixosConfigurations = lib.mapAttrs (name: _: nixosSystem name) (builtins.readDir ./hosts);
}
