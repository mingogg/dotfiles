#!/usr/bin/env bash

# Ensures there is a backup in case the folders exists, if not, creates the symlink to the repo
safe_link(){
  local target="$1"
  local link="$2"

  if [ -L "$link" ]; then
    ln -sfn "$target" "$link"

  elif [ -e "$link" ]; then
    mv "$link" "${link}.backup.$(date +%s)"
    ln -sfn "$target" "$link"

  else
    ln -sfn "$target" "$link"
  fi
}

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
safe_link "$DOTFILES_DIR/theme" "$CONFIG_DIR/theme"
safe_link "$DOTFILES_DIR/theme/default" "$CONFIG_DIR/theme/current"

# Hyprland
safe_link "$DOTFILES_DIR/config/hypr" "$CONFIG_DIR/hypr"

# Nvim
safe_link "$DOTFILES_DIR/config/nvim" "$CONFIG_DIR/nvim"

# Waybar
safe_link "$DOTFILES_DIR/config/waybar" "$CONFIG_DIR/waybar"
safe_link "$CONFIG_DIR/theme/current/waybar/style.css" "$CONFIG_DIR/waybar/style.css"

# BASH
safe_link "$DOTFILES_DIR/config/bashrc/.bashrc" "$HOME/.bashrc"

# Walker
safe_link "$DOTFILES_DIR/config/walker" "$CONFIG_DIR/walker"

# GTK Themes
safe_link "$CONFIG_DIR/theme/current/gtk/gtk-3.0" "$CONFIG_DIR/gtk-3.0"
safe_link "$CONFIG_DIR/theme/current/gtk/gtk-4.0" "$CONFIG_DIR/gtk-4.0"

# Greetd (login manager)
safe_link "$DOTFILES_DIR/config/greetd/config.toml" /etc/greetd/config.toml
