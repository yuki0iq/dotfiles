#!/bin/sh

rm -r ~/.vimrc ~/.bashrc ~/.gitconfig ~/shell.sh

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/bash-status-line/shell.sh ~/shell.sh

python3 -m pip install cmake
yay -S vim-lightline-git vim-youcompleteme-git thefuck

