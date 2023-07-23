#!/bin/sh

git submodule init
git submodule update

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/bash-status-line/shell.sh ~/shell.sh
ln -sf $PWD/.ssh/authorized_keys ~/.ssh/authorized_keys

# add own mirror with precompiled AUR packages!
sudo pacman -S vim-lightline-git vim-youcompleteme-git thefuck

