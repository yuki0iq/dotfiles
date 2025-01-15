# dotfiles

Yuki Sireneva's config files in one place and with uneasy install!

## Featuring

* GNOME and NetworkManager. Historically used systemd-networkd and sway

* `.bashrc` with aliases and cute prompt (`cargo +nightly install statusline`)

* Useless configuration

## Usage

```
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
vim /mnt/etc/fstab
arch-chroot /mnt

# Install bootloader here

echo 'reimu' > /etc/hostname
passwd
useradd -m -G wheel yuki
passwd yuki
su yuki

git clone https://github.com/yuki0iq/dotfiles
cd dotfiles

# sudo ./root.sh  # -- just follow the general idea
# ./home.sh       # -- just follow the general idea
. ~/.bashrc

paru -S rustup
rustup toolchain install nightly
cargo +nightly install statusline
. ~/.bashrc
```

Install scripts may break old files and will place symlinks to files in this repo. Do NOT delete cloned repo after installing!

