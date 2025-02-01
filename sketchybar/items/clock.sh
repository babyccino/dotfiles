#!/bin/bash

sketchybar --add item clock right \
    --set clock \
    icon=􀐬 \
    update_freq=10 \
    background.border_width=0 \
    script="$PLUGIN_DIR/clock.sh"
