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

