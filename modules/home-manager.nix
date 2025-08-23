{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
in {
  config = {
    home-manager = {
      extraSpecialArgs = {inherit pins;};
      sharedModules = [../home-modules];
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
