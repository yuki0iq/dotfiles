#!/bin/sh

rm -r ~/.vimrc ~/.vim ~/.bashrc ~/.gitconfig ~/shell.sh

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/bash-status-line/shell.sh ~/shell.sh

