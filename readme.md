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
git clone git@github.com:yuki0iq/dotfiles
cd dotfiles
sudo ./install-base.sh
./install-home.sh
```

Install scripts **REMOVE** old files and places symlinks to files in this repo. Do NOT delete cloned repo after installing!

