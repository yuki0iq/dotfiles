#!/bin/sh

paru -Syu \
  sway-git swaylock-effects eww-tray-wayland-git rofi-wayland \
  mate-polkit dunst grimshot inotify-tools \
  nwg-look materia-gtk-theme \
  qt5ct kvantum-qt5 \
  qt6ct kvantum kvantum-theme-materia \
  papirus-icon-theme \
  terminus-font{,-italic} ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  wayvnc waypipe \
  firefox \
  foot grc gef sublime-text-4 \
  xdg-desktop-portal{,-wlr,-gtk} \
  pipewire{,-pulse,-alsa,-jack} wireplumber \
  cmus cmus-plugin-vgm ffmpeg mpv \
  sound-theme-freedesktop \
  krita qbittorrent thunar imv engrampa \
  power-profiles-daemon \
  fcitx5-im fcitx5-mozc

paru -S --asdeps \
  thunar-{archive-plugin,volman}tumbler gvfs{,-gphoto2,-mtp} python-gobject

mkdir -p ~/.ssh ~/.local ~/.local/share ~/.local/state

ln -sf $PWD/home/.{bash{_profile,rc}} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/ ~/

