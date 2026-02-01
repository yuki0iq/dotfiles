self: {pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gcc
    gef
    python3
    rustup
    tokei
  ];
}
