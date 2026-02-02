self: {...}: {
  imports = [self.profiles.kernel];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.fwupd.enable = true;
}
