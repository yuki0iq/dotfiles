#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export QT_QPA_PLATFORMTHEME=qt5ct


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

