{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  imports = [
    (import "${pins.home-manager}/nixos")
  ];

  config = {
    home-manager = {
      sharedModules = [../home-modules];
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
