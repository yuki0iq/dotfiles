#!/bin/sh

rm -r ~/.vimrc ~/.bashrc ~/.gitconfig ~/shell.sh

git submodule init
git submodule update

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/bash-status-line/shell.sh ~/shell.sh

# add own mirror with precompiled AUR packages!
sudo pacman -S vim-lightline-git vim-youcompleteme-git thefuck

