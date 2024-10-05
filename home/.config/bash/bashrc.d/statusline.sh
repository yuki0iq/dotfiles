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
