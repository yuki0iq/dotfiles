{
  config,
  pkgs,
  pins,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "yuuka";

  virtualisation.docker = {
    enable = true;
    enableSysbox = true;
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
    prismlauncher
    (callPackage pins.yukigram {})

    gcc
    gef
    python3
    rustup
  ];

  meow.boot.enable = true;
  meow.graphical.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "sublimetext4"
    ];
  # XXX: https://github.com/NixOS/nixpkgs/issues/239615
  # Blocked on upstream: https://github.com/sublimehq/sublime_text/issues/5984
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
