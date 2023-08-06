#!/bin/sh

ln -sf $PWD/home/i3srs.toml ~/i3srs.toml
ln -sf $PWD/home/.config/i3/config ~/.config/i3/config

sudo pacman -S i3-wm i3lock i3status-rust \
  dmenu xcompmgr maim nitrogen st \
  terminus-font ttf-cascadia-code-nerd \
  xclip xdotool xorg-setxkbmap xorg-xinput
