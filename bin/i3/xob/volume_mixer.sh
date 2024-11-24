#!/bin/bash

if [ -z "$1" ]; then
	exit
fi

# Increase volume
if [ "$1" == "up" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ +5%
fi

# Decrease volume
if [ "$1" == "down" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

# Get the current volume level
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')

# Display the volume level using xob by streaming the volume level to the pipe
echo $VOLUME >> /tmp/xobpipe
