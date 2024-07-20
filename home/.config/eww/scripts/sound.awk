#!/bin/awk -f

BEGIN {
    volume = -1
    muted = 1
    mic_volume = -1
    mic_muted = 1

    iterate("sink")
    iterate("source")
}

# For every line of pulseaudio json nonsense that is actually interesting
/change/ {
    if ($0 ~ "\"sink\"") {
        iterate("sink")
    }
    if ($0 ~ "\"source\"") {
        iterate("source")
    }
}

function iterate(where) {
    # Query volume from wireplumber
    for (i in arr) { delete arr[i] }
    command = "wpctl get-volume @DEFAULT_" toupper(where) "@"
    command | getline line
    close(command)
    split(line, arr)
    new_volume = arr[2] * 100
    new_muted = arr[3] != ""
    if (where == "sink" && new_muted == muted && new_volume == volume) { return }
    if (where == "source" && new_muted == mic_muted && new_volume == mic_volume) { return }
    if (where == "sink") {
        muted = new_muted
        volume = new_volume
    }
    if (where == "source") {
        mic_muted = new_muted
        mic_volume = new_volume
    }

    # Report volume to supervisor
    print("{ \
        \"out\": { \
            \"vol\": " volume ", \
            \"muted\": " muted " \
        }, \
        \"in\": { \
            \"vol\": " mic_volume ", \
            \"muted\": " mic_muted " \
        } \
    }")
    fflush("/dev/stdout")

    # Report volume change to libcanberra
    system("canberra-gtk-play -i audio-volume-change &")

    # Report volume change to dunst
    icon = where == "sink" ? "audio-volume" : "microphone-sensitivity"
    icon = muted ? icon "-muted" : icon "-high"
    name = where == "sink" ? "Output" : "Input"
    name = muted ? name ", muted" : name
    cur_volume = where == "sink" ? volume : mic_volume
    # I will burn in hell for this kind of code
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
