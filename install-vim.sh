#!/bin/sh

ln -sf $PWD/home/.vimrc ~/.vimrc

# add own mirror with precompiled AUR packages!
sudo pacman -S vim-lightline-git vim-youcompleteme-git vim-monokai-git

