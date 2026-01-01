#!/usr/bin/env bash
source ~/.config/theme/current/colors/bashColors.sh

echo -e "${PRIMARY}---  INSTALLATION LIST  ---${RESET}"
echo -e "\n-- ${ACCENT}PACMAN UPDATES${RESET} --"

sleep 1
updates_pacman=$(checkupdates)

if [[ -n "$updates_pacman" ]]; then
    echo "$updates_pacman" | nl -s ". " -w 2
else
    echo "There is nothing to do"
fi

echo -e "\n-- ${ACCENT}AUR UPDATES${RESET} --"

updates_aur=$(yay -qua 2>/dev/null | grep "\->")

if [[ -n "$updates_aur" ]]; then
    echo "$updates_aur" | nl -s ". " -w 2
else
    echo "There is nothing to do"
fi

echo -e "\n${PRIMARY}--------------------------------${RESET}\n"

if [[ -z "$updates_pacman" && -z "$updates_aur" ]]; then
    echo -e "No updates found."
    echo -e "${PRIMARY}Press enter to close...${RESET}"
    read -r
    exit 0
fi

echo -n -e "Proceed with the installation? (${PRIMARY}Y${RESET}/${GIT_DIRTY}n${RESET}): "
read -r choice
choice=${choice,,}

if [[ "$choice" == "y" ]]; then
    echo -e "${PRIMARY}Initializing full installation...${RESET}"
    yay -Syu --noconfirm
    echo -e "\n${PRIMARY}Installation finished, press enter to close...${RESET}"
    read -r
else
    echo "Update cancelled by user, closing..."
    sleep 1
fi
