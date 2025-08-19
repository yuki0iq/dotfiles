{
  config,
  lib,
  pkgs,
  pins,
  ...
}: {
  imports = [
    ./basics.nix
    ./fonts.nix
    ./git.nix
    ./gnome.nix
    ./graphical.nix
    ./network.nix
    ./nix.nix
    ./proxies.nix
    ./ssh.nix
    ./system.nix
  ];

  config = {
    meow.basics = lib.mkDefault true;
    meow.network = lib.mkDefault true;
    meow.nix = lib.mkDefault true;
    meow.proxies = lib.mkDefault true;
    meow.system = lib.mkDefault true;
  };
}
