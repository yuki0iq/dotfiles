#!/bin/sh

paru -Syu \
  sway-git swaylock-effects eww-tray-wayland-git rofi-wayland \
  mate-polkit dunst grimshot inotify-tools \
  nwg-look materia-gtk-theme \
  breeze qt6ct-kde \
  terminus-font{,-italic} ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  wayvnc waypipe \
  firefox \
  foot grc gef sublime-text-4 \
  xdg-desktop-portal{,-wlr,-gtk} keepassxc \
  pipewire{,-pulse,-alsa,-jack} wireplumber cmus ffmpeg mpv sound-theme-freedesktop \
  krita qbittorrent thunar gvfs{,-gphoto2,-mtp} imv engrampa \
  power-profiles-daemon python-gobject \
  fcitx5-im fcitx5-mozc

mkdir -p ~/.ssh ~/.config ~/.config/sublime-text ~/.local ~/.local/share ~/.local/state

ln -sf $PWD/home/.{bash{_profile,rc},xkb} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dconf,dunst,easyeffects,eww,fcitx5,foot,gdb,git,gtk-3.0,htop,MangoHud,nvim,nwg-look,paru,qt6ct,rofi,sway} ~/.config/
