# dotfiles

Yuki Sireneva's config files in one place and with easy install!

## Featuring

* `.bashrc` with some aliases (modified from what i've got on my manjaro PC)

* `bash-status-line`

* `.vimrc` and vim plugins installed through AUR

* `git` configuration. __Note: this configuration uses me as a commit author__

## Usage 

```
git clone --recurse-submodules https://github.com/yuki0iq/dotfiles
cd dotfiles
./install.sh
```

Install script just **REMOVES** old files and places symlinks to files in this repo. Do NOT delete cloned repo after installing!

## Requirements

```
yay -S bash git vim yay
```

