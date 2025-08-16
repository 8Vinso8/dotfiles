#! /bin/fish

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "[MUTED]"
    notify-send -h string:x-canonical-private-synchronous:osd Mic "<span color='red'>MUTED</span>"
else
    notify-send -h string:x-canonical-private-synchronous:osd Mic "<span color='green'>UNMUTED</span>"
end
