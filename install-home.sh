#!/bin/sh

yay -Syyu sway-im swaylock kitty mate-polkit dunst grimshot eww-tray-wayland-git rofi-lbonn-wayland \
  gnome-desktop breeze inotify-tools nwg-look qt5ct dconf-editor materia-theme-git \
  terminus-font ttf-cascadia-code-nerd ttf-fantasque-sans-mono noto-fonts{,-cjk} \
  krita firefox qalculate-gtk transmission-qt mpv cmus ffmpeg rustup sublime-text-4 \
  mozc-ut fcitx5-{configtool,git,gtk,mozc-ut}

# add yourself to `video` group to control brightness...

mkdir -p ~/.ssh ~/.config ~/.config/sublime-text

ln -sf $PWD/home/.{bash{_profile,rc},gitconfig,xkb} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dunst,environment.d,eww,fcitx5,git,gtk-3.0,kitty,nwg-look,rofi,qt5ct,sway} ~/.config/
