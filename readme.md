# dotfiles

Yuki Sireneva's config files in one place and with almost easy install!

## Featuring

* `.bashrc` with some aliases

* To use bash-status-line-2, `cargo install statusline`

* `.vimrc` and vim plugins installed through AUR

* `git` aliases. __Note: this configuration uses me as a commit author__

## "X11" features

* `i3` environment with some fonts (TODO fix)

## Usage 

```
git clone --recurse-submodules gitea@git.yukii.keenetic.pro:yuki0iq/dotfiles
cd dotfiles
# <install scripts>
sudo ./install-base.sh
sudo ./install-network.sh
./install-init.sh
./install-home.sh
./install-vim.sh
./install-x11.sh
```

Install script just **REMOVES** old files and places symlinks to files in this repo. Do NOT delete cloned repo after installing!

### Install scripts:

* `install-base` for misc packages

* `install-network` for systemd-resolved, proper network handling and ssh

* `install-init` updates submodules

* `install-home` for bashrc, git config and ssh keys

* `install-vim` for vim configuration 

* `install-x11` for i3 environment

## Requirements

Pacman with prebuilt AUR

