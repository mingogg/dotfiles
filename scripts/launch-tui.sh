#!/usr/bin/env bash

# Usage:
# launch_tui.sh audio wiremix
# launch_tui.sh wifi nmtui
# launch_tui.sh sys btop

# To change the size of the tui see ~/dotfiles/config/hypr/windowrules.conf

ROLE="$1"
shift

[ -z "$ROLE" ] && exit 1
[ -z "$1" ] && exit 1

CLASS="tui-$ROLE"
TITLE="$ROLE"

if hyprctl clients -j | jq -e ".[] | select(.class == \"$CLASS\")" > /dev/null; then
    hyprctl dispatch focuswindow "class:^${CLASS}$"
else
    alacritty \
      --class "$CLASS" \
      --title "$TITLE" \
      -e "$@"
fi
