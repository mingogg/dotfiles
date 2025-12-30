#!/usr/bin/env bash

ROLE="$1"
shift

[ -z "$ROLE" ] && exit 1
[ -z "$1" ] && exit 1

CLASS="tui-$ROLE"
TITLE="$ROLE"

# Lanzar Alacritty con clase y título
alacritty --class "$CLASS" --title "$TITLE" -e "$@" &

# Esperar que Hyprland reconozca la ventana
sleep 0.1

# Buscar el WindowID correcto
WINID=$(hyprctl clients -j | jq -r --arg cls "$CLASS" '.[] | select(.class==$cls) | .address' | head -n1)

# Si se encontró, aplicar efectos
if [[ -n "$WINID" ]]; then
    hyprctl dispatch setfloating "$WINID" on
    hyprctl dispatch resizewindow "$WINID" 820 600
    hyprctl dispatch centerwindow "$WINID"
    hyprctl dispatch opacity "$WINID" 0.9
fi
