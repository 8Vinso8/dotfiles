#!/usr/bin/env bash

sleep="sleep"
logout="logout"
shutdown="shutdown"
reboot="reboot"

options="$shutdown\n$reboot\n$sleep\n$logout"

chosen=$(echo -e "$options" | rofi -dmenu -i)

case "$chosen" in
    "$sleep")
        systemctl suspend 
        ;;
    "$logout")
        hyprctl dispatch 'hl.dsp.exit()'
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
    esac
