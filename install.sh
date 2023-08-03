#!/bin/sh

git submodule init
git submodule update

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/bash-status-line/shell.sh ~/shell.sh
ln -sf $PWD/.ssh/authorized_keys ~/.ssh/authorized_keys
ln -sf $PWD/i3srs.toml ~/i3srs.toml
ln -sf $PWD/.config/i3/config ~/.config/i3/config

# add own mirror with precompiled AUR packages!
sudo pacman -S vim-lightline-git vim-youcompleteme-git st i3-wm i3lock dmenu i3status-rust terminus-font ttf-cascadia-code-nerd bat exa ripgrep

