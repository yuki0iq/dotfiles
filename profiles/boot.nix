self: {...}: {
  imports = [self.profiles.kernel];

  boot.loader.limine = {
    enable = true;
    efiInstallAsRemovable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  services.fwupd.enable = true;
}
