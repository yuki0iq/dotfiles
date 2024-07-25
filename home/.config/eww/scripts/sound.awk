#!/bin/awk -f

BEGIN {
    SINK = "sink"
    SOURCE = "source"

    volume[SINK] = -1
    volume[SOURCE] = -1
    muted[SINK] = 1
    muted[SOURCE] = 1

    iterate(SINK)
    iterate(SOURCE)
}

# For every line of pulseaudio json nonsense that is actually interesting
/change/ {
    if ($0 ~ "\"sink\"") {
        iterate(SINK)
    }
    if ($0 ~ "\"source\"") {
        iterate(SOURCE)
    }
}

function iterate(where,     cmd, arr, cur_volume, cur_muted, icon, name) {
    cmd = "wpctl get-volume @DEFAULT_" toupper(where) "@"
    cmd | getline line
    close(cmd)

    split(line, arr)
    cur_volume = arr[2] * 100
    cur_muted = arr[3] != ""

    if (cur_volume == volume[where] && cur_muted == muted[where]) { return }
    volume[where] = cur_volume
    muted[where] = cur_muted

    print("{ \
        \"out\": { \
            \"vol\": " volume[SINK] ", \
            \"muted\": " muted[SINK] " \
        }, \
        \"in\": { \
            \"vol\": " volume[SOURCE] ", \
            \"muted\": " muted[SOURCE] " \
        } \
    }")
    fflush("/dev/stdout")

    system("canberra-gtk-play -i audio-volume-change &")

    icon = where == "sink" ? "audio-volume" : "microphone-sensitivity"
    icon = cur_muted ? icon "-muted" : icon "-high"
    name = where == "sink" ? "Output" : "Input"
    name = cur_muted ? name ", muted" : name
    system("dunstify \
        -a wireplumber-watcher \
        -u low \
        -i " icon " \
        -h string:x-dunst-stack-tag:volume-" toupper(where) " \
        -h int:value:" cur_volume " \
        -t 1000 \
        \"" name "\" \
    &")
}
