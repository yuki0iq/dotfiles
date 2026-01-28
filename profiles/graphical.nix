self: {pkgs, ...}: {
  imports = [
    self.profiles.colemak-dh
    self.profiles.fonts
    self.profiles.pipewire
    self.profiles.mpv
  ];

  xdg.terminal-exec.package = pkgs.xdg-terminal-exec-mkhl;

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    waypipe
    wl-clipboard
    xkeyboard-config
    xwayland-satellite # waypipe dep
  ];
}
