{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    self.profiles.boot
    self.profiles.git-name
    self.profiles.gnome
    self.profiles.home-manager
    self.profiles.hplip
    self.profiles.locale
    self.profiles.network
    self.profiles.nix
    self.profiles.proxies
    self.profiles.shell
    self.profiles.shell-development
    self.profiles.shell-multimedia
    self.profiles.style-yuuka
  ];

  networking.hostName = "yuuka";

  virtualisation.docker = {
    enable = true;
    enableSysbox = true;
  };

  programs.obs-studio.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.yuki = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker" "wireshark"];
    openssh.authorizedKeys.keyFiles = [../../users/yuki/authorized_keys];
  };

  users.users.test = {
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = config.users.users.yuki.openssh.authorizedKeys.keyFiles;
  };

  home-manager.users.yuki = import ../../users/yuki;

  environment.systemPackages = with pkgs; [
    fractal
    self.packages.fjordlauncher
    self.packages.sublime4
    self.packages.yukigram
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
