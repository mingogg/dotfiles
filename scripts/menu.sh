#!/usr/bin/env bash

options=$(cat <<EOF
  Style: Change Theme
  System: Logout
  System: Reboot
  System: Shutdown
EOF
)

selected=$(echo "$options" | walker -d -p "Search...")

[ -z "$selected" ] && exit 0

case "$selected" in
  "Style: Change Theme")
    change-theme
    ;;
  "System: Logout")
    hyprctl dispatch exit
    ;;
  "System: Reboot")
    systemctl reboot
    ;;
  "System: Shutdown")
    systemctl poweroff
    ;;
esac
