#!/usr/bin/env bash

CURRENT="$HOME/.config/theme/current"

# Hyprland
hyprctl reload

# Bashrc / alacritty
source ~/.bashrc

# Wallpaper
pkill swaybg
sleep 0.1
nohup swaybg -i "$CURRENT/wallpaper/wallpaper.jpg" -m fill >/dev/null 2>&1 &
disown

# Waybar
pkill waybar
sleep 0.1
nohup waybar >/dev/null 2>&1 &
disown

# Ly login manager service will update the theme after rebooting the system
