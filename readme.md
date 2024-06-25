# dotfiles

Yuki Sireneva's config files in one place and with almost easy install!

## Featuring

* systemd-networkd config

* `.bashrc` with some aliases

* To use bash-status-line-2, `cargo +nightly install statusline`

* `git` aliases. __Note: this configuration uses me as a commit author__

* sway desktop with polybar or eww as a bar, and rofi-wayland

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
visudo  # allow `wheel` users to use sudo
su yuki

git clone https://github.com/yuki0iq/dotfiles
cd dotfiles
sudo ./root.sh
./home.sh
. ~/.bashrc

paru -S rustup
rustup toolchain install nightly
cargo +nightly install statusline
. ~/.bashrc
```

Install scripts **REMOVE** old files and places symlinks to files in this repo. Do NOT delete cloned repo after installing!

