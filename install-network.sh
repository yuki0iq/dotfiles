#!/bin/sh

pacman -S iwd openssh

# created as `diff -Naur sysd yuki > network.patch`
patch -d / -Np1 < patch/network.patch
patch -d / -Np1 < patch/ssh.patch

install -m0644 \
  root/etc/systemd/network/20-wired.network \
  root/etc/systemd/network/21-loopback.network \
  root/etc/systemd/network/25-wireless.network \
  /etc/systemd/network

systemctl enable --now systemd-timesyncd systemd-networkd systemd-resolved iwd
