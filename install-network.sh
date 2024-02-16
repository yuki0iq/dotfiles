#!/bin/sh

pacman -S iwd openssh

# created as `diff -Naur sysd yuki > network.patch`
patch -d / -Np1 < patch/network.patch

install -m0644 \
  root/etc/systemd/network/20-wired.network \
  root/etc/systemd/network/21-loopback.network \
  root/etc/systemd/network/25-wireless.network \
  /etc/systemd/network

install -m0644 \
  root/etc/ssh/ssh_config \
  root/etc/ssh/sshd_config \
  /etc/ssh

systemctl enable --now systemd-timesyncd systemd-networkd systemd-resolved iwd sshd
