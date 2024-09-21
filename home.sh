#!/bin/sh

paru -Syu \
  sway-git sway-systemd swaylock-effects rofi-wayland tcc \
  mate-polkit dunst grimshot \
  nwg-look materia-gtk-theme \
  qt5ct-kde breeze5 \
  qt6ct-kde breeze \
  papirus-icon-theme \
  terminus-font{,-italic} ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  wayvnc waypipe wdisplays \
  firefox \
  xdg-terminal-exec-mkhl foot grc gef sublime-text-4 \
  xdg-desktop-portal{,-wlr,-gtk} \
  pipewire{,-pulse,-alsa,-jack} wireplumber \
  cmus ffmpeg mpv \
  sound-theme-freedesktop \
  krita qbittorrent thunar imv engrampa \
  power-profiles-daemon \
  fcitx5-im fcitx5-mozc

paru -S --asdeps \
  thunar-{archive-plugin,volman}tumbler gvfs{,-gphoto2,-mtp} python-gobject

mkdir -p ~/.ssh ~/.local ~/.local/share ~/.local/state

ln -sf $PWD/home/.{bash{_profile,rc},config} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/

