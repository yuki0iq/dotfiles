#!/bin/bash

urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

extract_meta() {
    grep "$1\W" <<< "$meta" | awk '{$1=$2=""; print $0}' | sed 's/^ *//; s/; */;/g' | paste -s -d/ -
}

get_info() {
    if [[ -z "$1" ]]; then
        echo "Usage: get_info PLAYER"
        exit 1
    fi

    meta=$(playerctl -p "$1" metadata)

    title=$(extract_meta title)
    if [[ -z "$title" ]]; then
        title=$(extract_meta url)
        title=$(urldecode "${title##*/}")
    fi

    artist=$(extract_meta artist)
    [ -z "$artist" ] && artist=$(extract_meta albumArtist)

    if [[ -n "$artist" ]]; then
        echo -n "$artist | "

        album=$(extract_meta album)
        [[ -n "$album" ]] && echo -n "$album | "
    fi

    echo -n "$title"

    p_status=$(playerctl -p "$player" status 2>/dev/null)
    if [[ "$p_status" != "Playing" ]]; then
        echo -n " [$p_status]"
    fi
}

PLAYER="$(playerctl -l 2>/dev/null | head -1)"
[[ -n "$PLAYER" ]] && get_info "$PLAYER" && printf '\n'

