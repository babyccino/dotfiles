#!/bin/bash
LOCATION=$(~/.config/location_cli/location_cli.sh)
URL="https://wttr.in/${LOCATION}?format=j1"
RAW=$(curl $URL)
WEATHER=$(echo $RAW | jq '.current_condition.[0]')
TEMP=$(echo "$WEATHER" | jq '.temp_C' | tr -d '"')
WEATHER_CODE=$(echo "$WEATHER" | jq '.weatherCode' | tr -d '"')

ASTRONOMY=$(echo $RAW | jq '.weather.[0].astronomy.[0]')
SUNRISE=$(echo $ASTRONOMY | jq -r '.sunrise')
SUNSET=$(echo $ASTRONOMY | jq -r '.sunset')

TZ=$(gdate +"%Z %z")

SUNRISE="$SUNRISE $TZ"
SUNSET="$SUNSET $TZ"

SUNRISE=$(gdate --date="$SUNRISE" +"%s")
SUNSET=$(gdate --date="$SUNSET" +"%s")

CURRENT=$(gdate +"%s")

if (( CURRENT < SUNRISE )); then
  NIGHT="night"
elif (( CURRENT < SUNSET )); then
  NIGHT=""
else
  NIGHT="night"
fi

WEATHER_ICON=$(~/.config/sketchybar/plugins/weather_icon_map_fn.sh $WEATHER_CODE $NIGHT)

sketchybar --set weather label="${TEMP}°C" icon="$WEATHER_ICON"
