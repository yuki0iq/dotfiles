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

alias ls='exa --color=auto'
alias cat='bat'
alias eax='echo $?'

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

if [[ -z CARGOENV ]]; then
    export CARGOENV="${HOME}/.cargo/bin"
    export PATH="${CARGOENV}:${PATH}"
fi

if command -v statusline >/dev/null; then
    export PS1_MODE=minimal
    eval "$(statusline --env)"
fi

source /usr/share/git/completion/git-completion.bash
