#!/bin/awk -f

BEGIN {
    volume = -1
    muted = 1
}

# For every line of pulseaudio json nonsense that is actually interesting
/change/ { if ($0 ~ where) { iterate() } }

function iterate() {
    # Query volume from wireplumber
    for (i in arr) { delete arr[i] }
    command = "wpctl get-volume @DEFAULT_" toupper(where) "@"
    command | getline line
    close(command)
    split(line, arr)
    new_volume = arr[2] * 100
    new_muted = arr[3] != ""
    if (new_muted == muted && new_volume == volume) { return }
    muted = new_muted
    volume = new_volume

    # Report volume to supervisor
    printf("{\"vol\":%d,\"muted\":%d}\n", volume, muted)
    fflush("/dev/stdout")

    # Report volume change to libcanberra
    system("canberra-gtk-play -i audio-volume-change &")

    # Report volume change to dunst
    icon = where == "sink" ? "audio-volume" : "microphone-sensitivity"
    icon = muted ? icon "-muted" : icon "-high"
    name = where == "sink" ? "Output" : "Input"
    name = muted ? name ", muted" : name
    # I will burn in hell for this kind of code
    system("dunstify \
        -a wireplumber-watcher \
        -u low \
        -i " icon " \
        -h string:x-dunst-stack-tag:volume-" toupper(where) " \
        -h int:value:" volume " \
        -t 1000 \
        \"" name "\" \
    &")
}
