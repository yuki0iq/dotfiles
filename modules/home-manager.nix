{pins, ...}: {
  imports = ["${pins.home-manager}/nixos"];

  config.home-manager = {
    extraSpecialArgs = {inherit pins;};
    sharedModules = [../home-modules];
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
