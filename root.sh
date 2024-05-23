#!/bin/sh

pacman -Syu git
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

paru -Syu \
  bash diffutils patch sudo tmux bash-completion \
  pacman-contrib pkgfile bat eza git-delta ripgrep htop ncdu moreutils \
  bind iproute2 iputils nft iptables-nft iwd curl rsync openssh speedtest-cli w3m nmap \
  inxi nvim lsof strace ly terminus-font \
  nohang
paru -S --asdeps dmidecode

systemctl enable --now systemd-{timesyncd,networkd,resolved} iwd sshd ly-dm pkgfile-update.timer nftables nohang-desktop