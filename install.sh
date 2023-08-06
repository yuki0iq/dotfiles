#!/bin/sh

ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/bash-status-line/shell.sh ~/shell.sh
ln -sf $PWD/.ssh/authorized_keys ~/.ssh/authorized_keys

sudo pacman -S bat exa git-delta ripgrep

