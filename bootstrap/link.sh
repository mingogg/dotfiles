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

safe_link_root(){
  local target="$1"
  local link="$2"

  sudo mkdir -p "$(dirname "$link")"
  sudo ln -sfn "$target" "$link"
}

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

# If there is a config folder that's needed from the dotfiles, it goes from
# ~/gadearch/config to ~/.config/folder, else if there's a THEME needed, it goes from
# ~/.config/theme/current/folder to ~/.config/folder

REAL_HOME="$HOME"
CONFIG="$REAL_HOME/.config"
DOTFILES="$REAL_HOME/archkai"

echo -e "\n${BLUE}===================================${RESET}"
echo -e "${GREEN}[ LINK ] applyin dotfiles symlinks${RESET}"
echo -e "${BLUE}===================================${RESET}\n"

# Ensure base config directory exists (single source of truth for all symlinks)
mkdir -p "$CONFIG"

# Create the Theme system
safe_link "$DOTFILES/theme" "$CONFIG/theme"
safe_link "$DOTFILES/theme/default" "$CONFIG/theme/current"

# Hyprland
safe_link "$DOTFILES/config/hypr" "$CONFIG/hypr"

# Nvim
safe_link "$DOTFILES/config/nvim" "$CONFIG/nvim"

# Waybar
safe_link "$DOTFILES/config/waybar" "$CONFIG/waybar"
safe_link "$CONFIG/theme/current/colors/colors.css" "$CONFIG/waybar/colors.css"

# BASH
safe_link "$DOTFILES/config/bashrc/.bashrc" "$HOME/.bashrc"

# Walker
safe_link "$DOTFILES/config/walker" "$CONFIG/walker"
safe_link "$CONFIG/theme/current/colors/colors.css" "$CONFIG/walker/themes/current/colors.css"

# GTK Themes
safe_link "$CONFIG/theme/current/gtk/gtk-3.0" "$CONFIG/gtk-3.0"
safe_link "$CONFIG/theme/current/gtk/gtk-4.0" "$CONFIG/gtk-4.0"

# Ly (login manager)
echo -e "${BLUE}[ INFO ] Linking login manager system files (sudo required)${RESET}"
safe_link_root "$CONFIG/theme/current/ly/config.ini" "/etc/ly/config.ini"

# Colors for themes
safe_link "$CONFIG/theme/current/colors" "$CONFIG/colors"

# Mako
safe_link "$CONFIG/theme/current/mako" "$CONFIG/mako"

# btop
safe_link "$CONFIG/theme/current/btop" "$CONFIG/btop"

# wiremix
safe_link "$CONFIG/theme/current/wiremix" "$CONFIG/wiremix"

# tmux
safe_link "$DOTFILES/config/tmux" "$CONFIG/tmux"

# alacritty
safe_link "$DOTFILES/config/alacritty" "$CONFIG/alacritty"

# scripts executables in path
mkdir -p "$HOME/.local/bin"
for script in ~/archkai/scripts/*.sh; do
  [ -e "$script" ] || continue
  name=$(basename "$script" .sh)
  ln -sf "$script" "$HOME/.local/bin/$name"
done


