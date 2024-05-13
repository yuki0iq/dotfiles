#
# ~/.bash_profile
#

export XDG_DATA_HOME=~/.local/share
export XDG_CONFIG_HOME=~/.config
export XDG_STATE_HOME=~/.local/state
export XDG_CACHE_HOME=~/.cache

# Make xdg-open always prompt (probably)
export DE=flatpak

export QT_QPA_PLATFORMTHEME=qt6ct

[[ -z "$XDG_RUNTIME_DIR" ]] && export XDG_RUNTIME_DIR=/run/user/$(id -u)
SSH_ENV="$XDG_RUNTIME_DIR/ssh-agent-environment"

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

[[ -f ~/.bashrc ]] && . ~/.bashrc
