#
# ~/.bashrc
#

[[ $- != *i* ]] && return

export HISTFILE="${XDG_STATE_HOME}"/bash/history
export HISTSIZE=-1
export HISTFILESIZE=-1

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
        eval $(dircolors -b ~/.dir_colors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
    fi
fi

alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias nano='nvim'
alias ls='exa --color=auto'
alias cat='bat'
alias eax='echo $?'
alias ip='ip -c=always'
alias disas='~/kek/Mirror/disas/disas'

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

if [[ -z $CARGO_HOME ]]; then
    export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
    export CARGO_HOME="$XDG_DATA_HOME"/cargo
    export PATH="${PATH}:${CARGO_HOME}/bin"
fi

if command -v statusline >/dev/null; then
    export PS1_MODE=minimal
    eval "$(statusline --env)"
fi

export EDITOR=nvim
export PAGER='less -R'

source /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash
source /usr/share/doc/pkgfile/command-not-found.bash

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
export W3M_DIR="$XDG_DATA_HOME"/w3m
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
alias adb='HOME=$XDG_DATA_HOME/android adb'
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
