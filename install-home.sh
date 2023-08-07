#!/bin/sh

ln -sf $PWD/home/.bashrc ~/.bashrc
ln -sf $PWD/home/.gitconfig ~/.gitconfig
ln -sf $PWD/home/bash-status-line/shell.sh ~/shell.sh
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/authorized_keys

sudo pacman -S bat exa git-delta ripgrep

