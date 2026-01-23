{pins, ...}: {
  imports = ["${pins.home-manager}/nixos"];

  config.home-manager = {
    extraSpecialArgs = {inherit pins;};
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
