#!/usr/bin/env bash

CURRENT="$HOME/.config/theme/current"

hyprctl reload

pkill swaybg
sleep 0.1
nohup swaybg -i "$CURRENT/wallpaper/wallpaper.jpg" -m fill >/dev/null 2>&1 &
disown

pkill waybar
sleep 0.1
nohup waybar >/dev/null 2>&1 &
disown
