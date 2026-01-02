#!/usr/bin/env bash

THEMES_DIR="$HOME/archkai/theme"
CURRENT_LINK="$HOME/.config/theme/current"

# List all themes and select with walker, except 'current'
selected_theme=$(
  find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | walker -d -p "Select theme"
  )

# If not selected, exit
[ -z "$selected_theme" ] && exit 0

# Set symlink to the selected theme
ln -sfn "$THEMES_DIR/$selected_theme" "$CURRENT_LINK"

# Hotreload
relaunch-apps
