#!/bin/bash

echo "focued $FOCUSED_WORKSPACE arg $1"

if [ "$1" = "space.$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color="0x88001f30"
else
    sketchybar --set $NAME background.color="0x44001f30"
fi
