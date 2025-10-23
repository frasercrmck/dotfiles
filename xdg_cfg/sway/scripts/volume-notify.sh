#!/bin/sh

# Get the volume level and convert it to a percentage
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

muted=$(echo "$volume" | awk '{ if ($3 ~ "[MUTED]") { print "M" } }')

volume=$(echo "$volume" | awk '{print $2}')
volume=$(echo "( $volume * 100 ) / 1" | bc)

if [ "$muted" = "M" ]; then
  notify-send -t 1000 -a 'volume-notify' -h int:value:$volume "MUTED"
else
  notify-send -t 1000 -a 'volume-notify' -h int:value:$volume "Volume: ${volume}%"
fi
