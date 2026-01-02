#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

options=$(cat <<EOF
  ✦ Change Theme
  ⎋ Logout
  ↩ Reboot
  ⏻  Shutdown
EOF
)

selected=$(echo "$options" | walker -d -p "Search...")

[ -z "$selected" ] && exit 0

case "$selected" in
  "✦ Change Theme")
    change-theme
    ;;
  "⎋ Logout")
    hyprctl dispatch exit
    ;;
  "↩ Reboot")
    safeBraveReboot
    ;;
  "⏻  Shutdown")
    safeBravePoweroff
    ;;
esac
