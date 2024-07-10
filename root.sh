#!/bin/sh

pacman -Syu base-devel git
pushd /tmp
  git clone https://aur.archlinux.org/paru-bin.git
  pushd paru-bin
    makepkg -si
  popd
  rm -rf paru-bin
popd

paru -Syu rate-mirrors
rate-mirrors arch > /etc/pacman.d/mirrorlist

pushd root
  find -type f -exec install -vDm0644 {} /{} \;
popd

chmod 0400 /etc/doas.conf

locale-gen

paru -Syu \
  bash diffutils patch doas tmux bash-completion doas-sudo-shim-minimal busybox \
  pacman-contrib pkgfile bat eza git-delta ripgrep htop ncdu moreutils \
  bind iproute2 iputils nft iwd curl rsync openssh iperf3 w3m nmap \
  inxi nvim lsof strace ly terminus-font \
  nohang
paru -S --asdeps dmidecode

systemctl enable systemd-{timesyncd,networkd,resolved} iwd sshd ly-dm pkgfile-update.timer nftables nohang-desktop
