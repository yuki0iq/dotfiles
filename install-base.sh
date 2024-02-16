#!/bin/sh

pacman -S bash patch sudo which bat eza git-delta ripgrep bind curl inetutils iproute2 iputils \
  inxi neofetch onefetch tokei htop ncdu tmux vim mc lsof strace git openssh speedtest-cli w3m \
  iwd ly-dm kmsconvt

# TODO install yay

# created as `diff -Naur sysd yuki > network.patch`
patch -d / -Np1 < patch/network.patch

mkdir /etc/kmscon

install -m0644 root/etc/kmscon/kmscon.conf /etc/kmscon
install -m0644 root/etc/systemd/network/{20-wired,21-loopback,25-wireless}.network /etc/systemd/network
install -m0644 root/etc/ssh/{ssh,sshd}_config /etc/ssh
install -m0644 root/etc/environment /etc

systemctl enable --now systemd-timesyncd systemd-networkd systemd-resolved iwd sshd ly-dm