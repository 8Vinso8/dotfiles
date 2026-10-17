#!/usr/bin/env bash
set -euo pipefail

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -qF "[MUTED]"; then
  notify-send -h string:x-canonical-private-synchronous:osd Audio "<span color='#f38ba8'>Muted</span>"
else
  notify-send -h string:x-canonical-private-synchronous:osd Audio "<span color='#a6e3a1'>Unmuted</span>"
fi
