#!/usr/bin/env bash

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

echo ""
echo -e "${BLUE}===========================${RESET}"
echo -e "${GREEN}[ LINK ] Creating symlinks${RESET}"
echo -e "${BLUE}===========================${RESET}"
echo ""
# Create config folder
mkdir -p "$CONFIG_DIR"

# Hyprland
ln -sfn "$DOTFILES_DIR/config/hypr" "$CONFIG_DIR/hypr"

# Theme system
mkdir -p "$CONFIG_DIR/theme/current"
ln -sfn "$CONFIG_DIR/theme/default" "$CONFIG_DIR/theme/current"
