#!/bin/sh

STATUS_LABEL=$(lsappinfo info -only StatusLabel "Microsoft Teams")
if [[ $STATUS_LABEL =~ \"label\"=\"([0-9]+)\" ]]; then
  LABEL="${BASH_REMATCH[1]}"
  sketchybar --set teams  label="${LABEL}" \
                          label.color="0xffffffff" \
                          icon.color="0xffffffff" \
                          background.color="0x33ed8796"
elif [ "$STATUS_LABEL" ]; then
  sketchybar --set teams  label="•" \
                          label.color="0xffffffff" \
                          icon.color="0xffffffff" \
                          background.color="0x44001f30"
else
  sketchybar --set teams  label="•" \
                          label.color="0x99ffffff" \
                          icon.color="0x99ffffff" \
                          background.color="0x22001f30"
fi
