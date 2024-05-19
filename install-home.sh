#!/bin/sh

paru -Syu \
  sway-git swaylock-effects eww-tray-wayland-git rofi-wayland \
  mate-polkit dunst grimshot inotify-tools \
  gnome-desktop breeze nwg-look materia-gtk-theme qt6ct-kde grc \
  terminus-font{,-italic} ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  wayvnc waypipe firefox foot gef sublime-text-4 keepassxc \
  xdg-desktop-portal{,-wlr,-gtk} \
  cmus ffmpeg mpv sound-theme-freedesktop \
  krita qbittorrent thunar gvfs{,-gphoto2,-mtp} imv engrampa \
  power-profiles-daemon python-gobject

mkdir -p ~/.ssh ~/.config ~/.config/sublime-text ~/.local ~/.local/share ~/.local/state

ln -sf $PWD/home/.{bash{_profile,rc},xkb} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dconf,dunst,easyeffects,eww,foot,gdb,git,gtk-3.0,MangoHud,nvim,nwg-look,paru,qt6ct,rofi,sway} ~/.config/
