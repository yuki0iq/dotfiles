#!/bin/sh

paru -Syu \
  sway-git sway-systemd swaylock-effects xdg-desktop-portal{,-wlr,-gtk} foot \
  pipewire{,-pulse,-alsa,-jack} wireplumber sound-theme-freedesktop ffmpeg mpv fooyin-git \
  rofi-wayland xdg-terminal-exec-mkhl dunst grimshot \
  nwg-look materia-gtk-theme papirus-icon-theme qt5ct-kde breeze5 qt6ct-kde breeze grc \
  ttf-nerd-fonts-symbols ttf-fantasque-sans-mono ttf-dejavu noto-fonts{,-cjk} \
  wayvnc waypipe-git wdisplays \
  firefox krita qbittorrent loupe papers foliate sublime-text-4 \
  nautilus gvfs{,-gphoto2,-mtp} file-roller \
  gef \
  tuned \
  fcitx5-im fcitx5-mozc

mkdir -p ~/.ssh ~/.local ~/.local/share ~/.local/state

ln -sf $PWD/home/.{bash{_profile,rc},config} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/

