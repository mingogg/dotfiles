#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/dotfiles/scripts"

options=$(cat <<EOF
🎨  Style: Change Theme
⏻  System: Logout
🔁  System: Reboot
⏹  System: Shutdown
EOF
)

selected=$(echo "$options" | walker -d -p "Go...")

[ -z "$selected" ] && exit 0

case "$selected" in
  "🎨  Style: Change Theme")
    "$SCRIPTS_DIR/change_theme.sh"
    ;;
  "⏻  System: Logout")
    hyprctl dispatch exit
    ;;
  "🔁  System: Reboot")
    systemctl reboot
    ;;
  "⏹  System: Shutdown")
    systemctl poweroff
    ;;
esac
