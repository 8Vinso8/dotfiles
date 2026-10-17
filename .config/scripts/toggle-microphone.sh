#!/usr/bin/env bash
set -euo pipefail

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -qF "[MUTED]"; then
  notify-send -h string:x-canonical-private-synchronous:osd Mic "<span color='#f38ba8'>Muted</span>"
else
  notify-send -h string:x-canonical-private-synchronous:osd Mic "<span color='#a6e3a1'>Unmuted</span>"
fi
