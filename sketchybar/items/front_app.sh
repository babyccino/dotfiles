#!/bin/bash

sketchybar --add item front_app center \
           --set front_app \
           icon.font="sketchybar-app-font:Regular:15.0" \
           script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
