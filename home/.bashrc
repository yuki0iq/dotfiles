#
# ~/.bashrc
#

export DE=flatpak

export QT_QPA_PLATFORMTHEME=qt6ct

export XDG_RUNTIME_DIR=/run/user/$(id -u)

export XDG_DATA_HOME=~/.local/share
export XDG_CONFIG_HOME=~/.config
export XDG_STATE_HOME=~/.local/state
export XDG_CACHE_HOME=~/.cache

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

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

alias downspeed="iperf3 -c iperf3.moji.fr -p 5225"
alias upspeed="iperf3 -c iperf3.moji.fr -p 5225 -R"

alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias nano='nvim'
alias disas='~/kek/Mirror/disas/disas'

alias cat='bat'
alias ip='ip -c=always'
alias ls='eza --color=auto'

# Allow more colored commands when grc is present
if command -v grc >/dev/null; then
    grc='grc -se'
    alias blkid="$grc blkid"
    alias df="$grc df"
    alias dig="$grc dig"
    alias du="$grc du"
    alias env="$grc env"
    alias free="$grc free"
    alias lsblk="$grc lsblk"
    alias lsmod="$grc lsmod"
    alias lspci="$grc lspci"
    alias mount="$grc mount"
    alias nmap="$grc nmap"
    alias ping="$grc ping"
    alias stat="$grc stat"
    alias uptime="$grc uptime"
    unset grc
fi

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

export SSH_ENV="$XDG_RUNTIME_DIR/ssh-agent-environment"
ssh_agent_env() {
    ssh-agent > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    # ssh-add
}

if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    ps $SSH_AGENT_PID | grep ssh-agent$ > /dev/null || ssh_agent_env
else
    ssh_agent_env
fi

export EDITOR=nvim
export PAGER=less
export MANROFFOPT=-c
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

source /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash
source /usr/share/doc/pkgfile/command-not-found.bash

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
export W3M_DIR="$XDG_DATA_HOME"/w3m
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
