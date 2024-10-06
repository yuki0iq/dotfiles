case $TERM in
    linux|tmux-*)
        PS1_MODE=text
        ;;
    *)
        PS1_MODE=minimal
        ;;
esac
export PS1_MODE

if command -v statusline >/dev/null; then
    # statusline does the job for bash
    export MAILCHECK=-1
    eval "$(statusline env)"
fi
