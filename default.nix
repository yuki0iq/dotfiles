let
  bare_pins = import ./npins;
  pkgs = import bare_pins.nixpkgs {};
  pins = builtins.mapAttrs (name: pinned: pinned {inherit pkgs;}) bare_pins;

  lib = pkgs.lib;
  readDir' = dir: let
    contents = builtins.readDir dir;
    filtered = lib.filterAttrs (name: _: builtins.substring 0 1 name != "_") contents;
    toRealPath = name: _: lib.path.append dir name;
  in
    lib.mapAttrsToList toRealPath filtered;
  nixosSystem = name:
    (import "${pins.nixpkgs}/nixos") {
      specialArgs = {inherit pins;};
      configuration.imports = (readDir' ./modules) ++ [./hosts/${name}];
    };
in {
  nixosConfigurations = lib.mapAttrs (name: _: nixosSystem name) (builtins.readDir ./hosts);
}
