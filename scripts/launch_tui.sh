#!/usr/bin/env bash

# Use:
# launch_tui.sh audio wiremix
# launch_tui.sh wifi nmtui
# launch_tui.sh sys btop

ROLE="$1"
shift

[ -z "$ROLE" ] && exit 1
[ -z "$1" ] && exit 1

CLASS="tui-$ROLE"
TITLE="$ROLE"

alacritty \
  --class "$CLASS" \
  --title "$TITLE" \
  -e "$@"

