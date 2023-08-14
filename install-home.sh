#!/bin/sh

ln -sf $PWD/home/.bashrc ~/.bashrc
ln -sf $PWD/home/.gitconfig ~/.gitconfig
ln -sf $PWD/home/.ssh/authorized_keys ~/.ssh/authorized_keys
mkdir -p ~/.config/git
ln -sf $PWD/home/.config/git/allowed_signers ~/.config/git/allowed_signers

sudo pacman -S bat exa git-delta ripgrep

