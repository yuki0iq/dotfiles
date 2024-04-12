#!/bin/sh

paru -Syyu sway-im swaylock kitty mate-polkit dunst grimshot eww-tray-wayland-git rofi-lbonn-wayland \
  gnome-desktop breeze inotify-tools nwg-look dconf-editor materia-gtk-theme \
  terminus-font{,-italic} ttf-nerd-fonts-symbols ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  krita firefox qbittorrent mpv cmus ffmpeg rustup sublime-text-4 fcitx5-{configtool,gtk,mozc} gef \
  wayvnc bash-completion

# add yourself to `video` group to control brightness...

mkdir -p ~/.ssh ~/.config ~/.config/sublime-text

ln -sf $PWD/home/.{bash{_profile,rc},xkb} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dconf,dunst,easyeffects,eww,fcitx5,gdb,git,gtk-3.0,kitty,MangoHud,nvim,nwg-look,paru,rofi,sway} ~/.config/
