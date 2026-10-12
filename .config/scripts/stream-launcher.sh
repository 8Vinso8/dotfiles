#!/usr/bin/env bash

# Grab the clipboard content, removing any trailing newlines
URL=$(wl-paste -n)

# Basic validation to ensure the clipboard contains a URL
if [[ ! "$URL" =~ ^https?:// ]]; then
    notify-send "Stream Launcher" "Clipboard does not contain a valid URL."
    exit 1
fi

# Check for YouTube URLs (matches youtu.be or youtube.com)
if [[ "$URL" =~ youtube\.com|youtu\.be ]]; then
    notify-send "Stream Launcher" "Queuing YouTube video..."
    # Run umpv in the background and discard terminal output
    umpv "$URL" > /dev/null 2>&1 &

# Check for Twitch URLs
elif [[ "$URL" =~ twitch\.tv ]]; then
    notify-send "Stream Launcher" "Queuing Twitch stream via Streamlink..."
    # Tell streamlink to use umpv as the player, streaming at 'best' quality
    streamlink --player mpv "$URL" best > /dev/null 2>&1 &

# Fallback for other URLs
else
    notify-send "Stream Launcher" "URL not recognized as YouTube or Twitch."
    # Optional: You can uncomment the line below to try playing unknown URLs with umpv anyway
    # umpv "$URL" > /dev/null 2>&1 &
fi
