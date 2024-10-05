#
# ~/.bashrc
#

for file in ~/.config/environment.d/*.conf; do
    source <(sed 's|^|export |' $file)
done

export XDG_RUNTIME_DIR=/run/user/$(id -u)

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
alias yay='paru'

alias cat='bat'
alias ip='ip -c=always'
alias ls='eza --color=auto'
alias diff='diff --color=auto'

alias psu='ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd'
alias psc='ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd'

# Allow more colored commands when grc is present
if command -v grc >/dev/null; then
    grc='grc -se'
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
    alias w="$grc w"
    alias who="$grc who"
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

if [[ $TERM == linux ]]; then
    export PS1_MODE=text
else
    export PS1_MODE=minimal
fi

if command -v statusline >/dev/null; then
    # statusline does the job for bash
    export MAILCHECK=-1
    eval "$(statusline env)"
fi

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export EDITOR=nvim
export PAGER='less -R +X'
export MANROFFOPT=-c
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

source <(printf "original_" && cat /usr/share/doc/pkgfile/command-not-found.bash)

command_not_found_handle () {
    local cmd=$1

    if busybox --list | grep ^$cmd\$ >/dev/null 2>&1; then
        busybox "$@"
    else
        original_command_not_found_handle "$@"
    fi

    return 127
}

export WINEPREFIX="$XDG_DATA_HOME"/wine

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
export W3M_DIR="$XDG_DATA_HOME"/w3m
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
export LESSHISTFILE="$XDG_STATE_HOME"/lesshst
export MINETEST_USER_PATH="$XDG_DATA_HOME"/minetest

