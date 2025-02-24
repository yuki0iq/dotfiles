#!/bin/sh

paru -Syu \
  gdm gnome-shell gnome-control-center refine-git ibus-anthy ibus-table-extra \
  gnome-shell-extensions gnome-shell-extension-{caffeine,legacy-theme-auto-switcher-git} \
  gst-plugin-pipewire gst-plugins-bad gnome-remote-desktop fwupd malcontent \
  pipewire{,-pulse,-alsa,-jack} wireplumber sound-theme-freedesktop ffmpeg mpv fooyin-git \
  foot xdg-terminal-exec-mkhl grc gef wl-clipboard \
  qt5ct-kde breeze5 qt6ct-kde breeze adw-gtk-theme \
  ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  firefox krita kolourpaint qbittorrent sublime-text-4 obs-studio \
  nautilus gvfs{,-gphoto2,-mtp} file-roller loupe identity papers foliate \
  power-profiles-daemon

mkdir -p ~/.ssh ~/.local ~/.local/share ~/.local/state ~/.local/share/flatpak

ln -sf $PWD/home/.{bash{_profile,rc},config,var} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/

ln -sf ~/.config/flatpak/overrides ~/.local/share/flatpak/

