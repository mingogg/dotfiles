#!/usr/bin/env bash

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

echo -e "\n${BLUE}====================================${RESET}"
echo -e "${GREEN}[ ENABLE ] Enabling system services${RESET}"
echo -e "${BLUE}====================================${RESET}\n"

# Enables network connection
sudo systemctl enable --now NetworkManager

# Docker
if systemctl list-unit-files | grep -q docker.service; then
  sudo systemctl enable --now docker

  USER_NAME="$(id -un)"
  sudo usermod -aG docker "$USER_NAME"
fi

# Re-launch apps to apply theme for the first time
relaunch-apps

# Ly (login manager)
sudo systemctl disable getty@tty1.service
sudo systemctl enable getty@tty2.service
sudo systemctl enable ly@tty1.service
