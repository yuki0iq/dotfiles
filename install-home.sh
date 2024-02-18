#!/bin/sh

yay -Syyu swaylock kitty lxsession-gtk3 dunst \
  terminus-font ttf-cascadia-code-nerd ttf-fantasque-sans-mono noto-fonts noto-fonts-cjk \
  qt5ct nwg-look krita firefox qalculate-gtk transmission-qt mpv cmus ffmpeg rustup \
  grimshot sway-im eww-tray-wayland-git rofi-lbonn-wayland sublime-text-4 inotify-tools

# add yourself to `video` group to control brightness...

mkdir -p ~/.ssh ~/.config ~/.config/sublime-text

ln -sf $PWD/home/.{bash{_profile,rc},gitconfig} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dunst,environment.d,eww,git,gtk-3.0,kitty,nwg-look,rofi,qt5ct,sway} ~/.config/
