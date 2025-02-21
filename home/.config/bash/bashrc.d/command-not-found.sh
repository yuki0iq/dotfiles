source <(printf "original_" && cat /usr/share/doc/pkgfile/command-not-found.bash)

command_not_found_handle () {
    local cmd=$1

    if busybox --list | grep ^$cmd\$ >/dev/null 2>&1; then
        if tty -s; then
            printf "\e[33m\e[3m--> Using busybox for '%s'\e[m\n" $cmd
        fi
        exec busybox "$@"
    else
        original_command_not_found_handle "$@"
    fi

    return 127
}

