#!/bin/sh

curl https://yukii.keenetic.pro/wall/im.png -o ~/wallpaper.png

ln -sf $PWD/home/i3srs.toml ~/i3srs.toml
ln -sf $PWD/home/.config/i3/config ~/.config/i3/config

yay -S i3-wm i3lock i3status-rust \
  dmenu feh kitty maim xcompmgr \
  terminus-font ttf-cascadia-code-nerd \
  xclip xdotool xorg-setxkbmap xorg-xinput
