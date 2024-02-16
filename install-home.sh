#!/bin/sh

yay -Syyu swaylock kitty grim lxsession-gtk3 dunst \
  terminus-font ttf-cascadia-code-nerd ttf-fantasque-sans-mono noto-fonts noto-fonts-cjk \
  qt5ct krita firefox qalculate-gtk transmission-qt mpv cmus ffmpeg rustup \
  grimshot sway-im eww-wayland rofi-lbonn-wayland sublime-text-4

mkdir -p ~/.ssh ~/.config ~/.config/eww ~/.config/sublime-text

ln -sf $PWD/home/.{bashrc,gitconfig} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/eww/bar ~/.config/eww/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dunst,git,kitty,rofi,qt5ct,sway} ~/.config/
