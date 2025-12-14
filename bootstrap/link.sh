#!/usr/bin/env bash

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

echo ""
echo -e "${BLUE}===================================${RESET}"
echo -e "${GREEN}[ LINK ] applyin dotfiles symlinks${RESET}"
echo -e "${BLUE}===================================${RESET}"
echo ""

# Ensure base config directory exists (single source of truth for all symlinks)
mkdir -p "$CONFIG_DIR"

# Create the Theme system
ln -sfn "$DOTFILES_DIR/theme" "$CONFIG_DIR/theme"

# Hyprland
rm -rf "$CONFIG_DIR/hypr"
ln -sfn "$DOTFILES_DIR/config/hypr" "$CONFIG_DIR/hypr"

# Nvim
rm -rf "$CONFIG_DIR/nvim"
ln -sfn "$DOTFILES_DIR/config/nvim" "$CONFIG_DIR/nvim"

# Waybar
ln -sfn "$DOTFILES_DIR/config/waybar" "$CONFIG_DIR/waybars"
