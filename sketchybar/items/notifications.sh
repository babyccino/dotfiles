#!/bin/bash

sketchybar --add item outlook right \
           --set outlook \
                 update_freq=5 \
                 script="$PLUGIN_DIR/notifications.sh" \
                 icon.font="sketchybar-app-font:Mono:15.0" \
                 click_script="open -a 'Microsoft Outlook'"\
                 icon="􀍖"\
           --subscribe outlook system_woke

sketchybar --add item teams right \
           --set teams \
                 icon.font="sketchybar-app-font:Mono:15.0" \
                 click_script="open -a 'Microsoft Teams'"\
                 icon="󰊻"\
           --subscribe teams system_woke
