# dotfiles

Yuki Sireneva's config files in one place and with almost easy install!

## Featuring

* `.bashrc` with some aliases

* `bash-status-line` (bash version). To use rust version, use `cargo install statusline`

* `.vimrc` and vim plugins installed through AUR

* `git` aliases. __Note: this configuration uses me as a commit author__

## "X11" features

* `i3` environment with some fonts (TODO fix)

## Usage 

```
git clone --recurse-submodules https://github.com/yuki0iq/dotfiles
cd dotfiles
# <install scripts>
./install-init.sh
./install.sh
./install-vim.sh
./install-x11.sh
```

Install script just **REMOVES** old files and places symlinks to files in this repo. Do NOT delete cloned repo after installing!

### Install scripts:

* `install-init` updates submodules

* `install` for bashrc, git config and ssh keys

* `install-vim` for vim configuration 

* `install-x11` for i3 environment

## Requirements

```
yay -S bash git vim yay
```

