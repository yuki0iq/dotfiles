#!/bin/sh
if [[ swaymsg -t get_inputs | rg Colemak >/dev/null ]]; then
    swaymsg input '* xkb_variant ","'
else
    swaymsg input '* xkb_variant "colemak_dh_yuki,rulemak_dh_yuki"'
fi
