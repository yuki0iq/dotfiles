#!/bin/bash

cmd="${0%/*}/mpris_get_status.sh $1"
zscroll -l 30 -p "        " -d 0.2 -U 10 -u t "$cmd" &
wait
