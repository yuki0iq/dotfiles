if command -v statusline >/dev/null; then
    export PS1_MODE=minimal
    source <(statusline env)
fi
