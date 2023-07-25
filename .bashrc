#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
        eval $(dircolors -b ~/.dir_colors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
    fi
fi

alias ls='ls --color=auto'

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

export PATH="${HOME}/.cargo/bin:${PATH}"

if command -v statusline >/dev/null; then
    export PS1_MODE=minimal
    eval "$(statusline --env)"
else
    source ~/shell.sh
fi

source /usr/share/git/completion/git-completion.bash

eval "$(thefuck --alias)"
