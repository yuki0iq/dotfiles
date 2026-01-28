self: {...}: {
  imports = ["${self.pins.home-manager}/nixos"];

  home-manager = {
    extraSpecialArgs = {inherit self;};
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
