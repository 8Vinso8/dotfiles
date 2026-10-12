#!/usr/bin/env bash

# Replace these with your actual wpctl IDs or pactl sink names
HEADPHONES_ID=60
SPEAKERS_ID=59

# Menu options
HEADPHONES="🎧 Headphones"
SPEAKERS="🔊 Speakers"

chosen=$(echo -e "$HEADPHONES\n$SPEAKERS" | rofi -dmenu -i)

case "$chosen" in
    "$HEADPHONES")
        wpctl set-default "$HEADPHONES_ID"
        ;;
    "$SPEAKERS")
        wpctl set-default "$SPEAKERS_ID"
        ;;
esac

