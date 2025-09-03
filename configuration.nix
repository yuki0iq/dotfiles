# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  pins = let
    pins = import ./npins;
    # XXX: Can't reference neither toplevel `pkgs` nor `config.nixpkgs.pkgs` here. Using these will
    # result in infinite recursion whenever `pins` are used in `imports`.
    # This can be fixed by supplying nixpkgs with overlays *and* correct pins from outside like with
    # flakes or colmena. How cursed it is to make a second nixpkgs evaluation just for fetchers...
    pkgs = import pins.nixpkgs {};
    applyPkgs = name: pinned: pinned {inherit pkgs;};
  in
    builtins.mapAttrs applyPkgs pins;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./modules

    (import "${pins.lix-nixos-module}/module.nix" {lix = null;})
    (import "${pins.home-manager}/nixos")
  ];

  _module.args = {inherit pins;};

  boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "yuuka";

  services.fwupd.enable = true;

  virtualisation.docker.enable = true;

  users.users.yuki = {
    isNormalUser = true;
    description = "yuki";
    extraGroups = ["networkmanager" "wheel" "docker" "wireshark"];
    openssh.authorizedKeys.keyFiles = [./users/yuki/authorized_keys];
  };

  home-manager.users.yuki = import ./users/yuki;

  nixpkgs.overlays = [
    (self: super: rec {
      fenix = self.callPackage pins.fenix {};
      rycee = self.callPackage pins.rycee {};
      statusline = self.callPackage "${pins.statusline}/statusline.nix" {};
      yukigram = self.callPackage pins.yukigram {};

      fenixToolchain = fenix.complete.toolchain;
    })
  ];

  environment.systemPackages = with pkgs; [
    fractal
    prismlauncher
    yukigram

    gcc
    gef
    fenixToolchain
  ];

  meow.graphical = true;

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
