{self, ...}: {
  imports = ["${self.pins.home-manager}/nixos"];

  config.home-manager = {
    extraSpecialArgs = {inherit self;};
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
