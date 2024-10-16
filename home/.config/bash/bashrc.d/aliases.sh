alias downspeed="iperf3 -c iperf3.moji.fr -p 5225"
alias upspeed="iperf3 -c iperf3.moji.fr -p 5225 -R"

alias disas='~/kek/Mirror/disas/disas'
alias yay='paru'

alias cat='bat'
alias ip='ip -c=always'
alias ls='eza --color=auto'
alias diff='diff --color=auto'

alias psu='ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd'
alias psc='ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd'

alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias nano='nvim'

alias userctl='systemctl --user'

export EDITOR=nvim
export PAGER='less -R +X'
export MANROFFOPT=-c
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

shopt -s expand_aliases
