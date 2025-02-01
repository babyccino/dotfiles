#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon="􀫥" \
                      icon.font="sketchybar-app-font:Regular:15.0" \
                      background.border_width=0 \
                      script="$PLUGIN_DIR/cpu.sh" \
                      label.align=right \
                      label.width=45 \
                      align=right
