#!/bin/awk -f

BEGIN {
    SINK = "sink"
    SOURCE = "source"

    volume[SINK] = -1
    volume[SOURCE] = -1
    muted[SINK] = 1
    muted[SOURCE] = 1
    icon[SINK] = "audio-volume-high"
    icon[SOURCE] = "mic-volume-high"

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

function iterate(where,     cmd, arr, cur_volume, cur_muted, cur_icon, name) {
    cmd = "wpctl get-volume @DEFAULT_" toupper(where) "@"
    cmd | getline line
    close(cmd)

    split(line, arr)
    cur_volume = arr[2] * 100
    cur_muted = arr[3] != ""

    cur_icon =
        cur_muted ? "muted" :
        cur_volume > 50 ? "high" :
        cur_volume > 25 ? "medium" :
        cur_volume > 0 ? "low" : "muted"
    cur_icon = (where == "sink" ? "audio" : "mic") "-volume-" cur_icon

    if (cur_volume == volume[where] && cur_muted == muted[where]) { return }
    volume[where] = cur_volume
    muted[where] = cur_muted
    icon[where] = cur_icon

    print("{ \
        \"out\": { \
            \"vol\": " volume[SINK] ", \
            \"muted\": " muted[SINK] ", \
            \"icon\": \"" icon[SINK] "\" \
        }, \
        \"in\": { \
            \"vol\": " volume[SOURCE] ", \
            \"muted\": " muted[SOURCE] ", \
            \"icon\": \"" icon[SOURCE] "\" \
        } \
    }")
    fflush("/dev/stdout")

    system("canberra-gtk-play -i audio-volume-change &")

    name = where == "sink" ? "Output" : "Input"
    name = cur_muted ? name ", muted" : name
    system("dunstify \
        -a wireplumber-watcher \
        -u low \
        -i " cur_icon " \
        -h string:x-dunst-stack-tag:volume-" toupper(where) " \
        -h int:value:" cur_volume " \
        -t 1000 \
        \"" name "\" \
    &")
}
