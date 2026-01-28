self: {...}: {
  imports = [self.profiles.kernel];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.fwupd.enable = true;
}
