#!/usr/bin/env bash

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

echo ""
echo -e "${BLUE}====================================${RESET}"
echo -e "${GREEN}[ ENABLE ] Enabling system services${RESET}"
echo -e "${BLUE}====================================${RESET}"
echo ""

echo -e "${GREEN}[ ENABLE ] NetworkManager${RESET}"
# Network
sudo systemctl enable --now NetworkManager

echo -e "${GREEN}[ ENABLE ] Docker${RESET}"
# Docker
if systemctl list-unit-files | grep -q docker.service; then
  sudo systemctl enable --now docker

  USER_NAME="$(id -un)"
  sudo usermod -aG docker "$USER_NAME"
fi

echo ""
echo -e "${GREEN}[ ENABLE ] Done${RESET}"
echo ""
