#!/usr/bin/env bash

# Saves the direction of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Installing the applications needed
bash "$SCRIPT_DIR/install_apps.sh"

# Create the symlink for the configs & themes
bash "$SCRIPT_DIR/link.sh"

# Has to be installed after creating the /.local/bin folder
pipx install terminaltexteffects # terminal effects for the screensaver

# Enables needed for the system to work
bash "$SCRIPT_DIR/enable.sh"

echo -e "\n${BLUE}===================================${RESET}"
echo -e "${GREEN}Reboot the system to apply changes${RESET}"
echo -e "${BLUE}===================================${RESET}\n"
