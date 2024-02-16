#!/bin/sh

yay -S sway swaylock eww-wayland rofi-wayland kitty grim lxpolkit dunst \
  terminus-font ttf-cascadia-code-nerd ttf-fantasque-sans-mono noto-fonts noto-fonts-cjk \
  qt5ct subl krita firefox qalculate transmission mpv cmus ffmpeg rustup

mkdir ~/.ssh ~/.config ~/.config/eww ~/.config/sublime-text

ln -sf $PWD/home/.{bashrc,gitconfig} ~/
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/
ln -sf $PWD/home/.config/eww/bar ~/.config/eww/
ln -sf $PWD/home/.config/sublime-text/Packages ~/.config/sublime-text/

ln -sf $PWD/home/.config/{dunst,git,kitty,rofi,qt5ct,sway} ~/.config/
