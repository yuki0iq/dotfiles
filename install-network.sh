#!/bin/sh
# sudo.

pacman -S iwd

# created as `diff -Naur sysd yuki > network.patch`
patch -d / -Np1 < patch/network.patch

ln -sf $PWD/root/etc/systemd/network/20-wired.network /etc/systemd/network/20-wired.network
ln -sf $PWD/root/etc/systemd/network/25-wireless.network /etc/systemd/network/25-wireless.network

systemctl enable --now systemd-timesyncd systemd-networkd systemd-resolved iwd
