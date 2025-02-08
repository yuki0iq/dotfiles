alias downspeed="iperf3 -c iperf3.moji.fr -p 5225"
alias upspeed="iperf3 -c iperf3.moji.fr -p 5225 -R"

alias disas='~/kek/Mirror/disas/disas'
alias yay='paru'

alias cat='bat'
alias ip='ip -c=always'
alias ls='eza --color=auto --hyperlink'
alias diff='diff --color=auto'

alias psu='ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,ucmd'
alias psc='ps ouser:8,tid:6,pri,bsdtime:6,pss:10,rss:10,uss:10,oom,tt:5,stat,cmd'

alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias nano='nvim'

alias userctl='systemctl --user'

export EDITOR=nvim
export PAGER=less
export LESS='-R -F'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

shopt -s expand_aliases
