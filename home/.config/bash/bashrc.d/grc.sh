# Allow more colored commands when grc is present
if ! command -v grc >/dev/null; then
    return
fi

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

