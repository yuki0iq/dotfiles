#!/bin/sh

paru -Syu \
  sway-im swaylock-effects eww-tray-wayland-git rofi-wayland \
  mate-polkit dunst grimshot inotify-tools \
  fcitx5-{configtool,gtk,mozc} \
  gnome-desktop breeze nwg-look materia-gtk-theme qt6ct \
  terminus-font{,-italic} ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  wayvnc waypipe firefox kitty gef sublime-text-4 keepassxc \
  xdg-desktop-portal-gtk \
  krita qbittorrent cmus ffmpeg mpv

mkdir -p ~/.ssh ~/.config ~/.config/sublime-text ~/.local ~/.local/share ~/.local/state

ln -sf $PWD/home/.{bash{_profile,rc},xkb} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dconf,dunst,easyeffects,eww,fcitx5,gdb,git,gtk-3.0,kitty,MangoHud,nvim,nwg-look,paru,qt6ct,rofi,sway} ~/.config/
