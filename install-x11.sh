#!/bin/sh

ln -sf $PWD/i3srs.toml ~/i3srs.toml
ln -sf $PWD/.config/i3/config ~/.config/i3/config

sudo pacman -S i3-wm i3lock i3status-rust \
  dmenu xcompmgr nitrogen st \
  terminus-font ttf-cascadia-code-nerd
