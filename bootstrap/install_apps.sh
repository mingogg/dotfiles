#!/usr/bin/env bash

BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

printIt() {
  local text="$1"
  echo -e "\n${BLUE}==========================${RESET}"
  echo -e "${GREEN}${text}${RESET}"
  echo -e "${BLUE}==========================${RESET}\n"
}

# Ensure system time is correct (required for SSL / git / AUR)
sudo timedatectl set-ntp true

# Force the update of the system
sudo pacman -Syu --noconfirm

# SYSTEM - core infrastructure
printIt "[ SYSTEM ] Installing infrastructure"
SYSTEM_PKGS=(
  networkmanager                # network connectivity
  pipewire                      # audio/video engine
  wireplumber                   # audio session manager
  xdg-desktop-portal            # apps ↔ system bridge
  xdg-desktop-portal-hyprland   # Wayland portal (Hyprland)
  base-devel                    # build tools (yay)
  git                           # clone PKGBUILDs
  ttf-nerd-fonts-symbols        # symbols render
  ttf-jetbrains-mono-nerd       # system font
  pacman-contrib                # tools to enhance pacman
  python                        # python 3 interpreter
  python-pip                    # python pkg manager
  python-pipx                   # python pkg manager for isolated Python apps (i.e., tte)
)

sudo pacman -S --needed --noconfirm "${SYSTEM_PKGS[@]}"

printIt "[ SYSTEM ] Installing yay"
if ! command -v yay >/dev/null 2>&1; then
  echo "${GREEN}[ AUR ] Installing yay...${RESET}\n"

  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay || exit 1
  makepkg -si --noconfirm
  cd -
else
  echo -e "${GREEN}[ SYSTEM ] yay already installed${RESET}"
fi

[ -d /tmp/yay ] && rm -rf /tmp/yay

# APPS - essential user tools from pacman
printIt "[ APPS ] Installing essential user tools"
APPS_PKGS=(
  which               # command locator (diagnostics)
  docker              # container engine
  docker-compose      # compose support
  btop                # resource monitor
  alacritty           # terminal emulator
  nvim                # text editor, obviously
  tmux                # terminal multiplexor
  dbeaver             # database tool
  nautilus            # file manager
  wiremix             # TUI audio mixer
  hypridle            # idle management daemon
  wl-clipboard        # clipboard (Wayland)
  hyprshot            # screenshot utility
  hyprlock            # lockscreen
  ly                  # login manager
  mako                # notification daemon
  waybar              # status bar
  swaybg              # wallpaper manager
)

sudo pacman -S --needed --noconfirm "${APPS_PKGS[@]}"

printIt "[ CHECK ] Verifying installed packages"

FAILED_PKGS=()

for pkg in "${APPS_PKGS[@]}"; do
  if ! pacman -Q "$pkg" &>/dev/null; then
    FAILED_PKGS+=("$pkg")
  fi
done

if (( ${#FAILED_PKGS[@]} > 0 )); then
  printIt "[ ERROR ] The following packages failed to install:"
  for pkg in "${FAILED_PKGS[@]}"; do
    echo "  - $pkg"
  done
  exit 1
fi

printIt "[ OK ] All essential packages installed"

# APPS - essential user tools from AUR
AUR_APPS_PKGS=(
  lazydocker          # terminal UI for managing Docker containers
  walker              # app launcher
  brave-bin           # web browser
  postman-bin         # testing APIs
  xdg-terminal-exec   # utility (screensaver uses it)
)

AUR_MISSING_PKGS=()
for pkg in "${AUR_APPS_PKGS[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    AUR_MISSING_PKGS+=("$pkg")
  fi
done

if [ "${#AUR_MISSING_PKGS[@]}" -gt 0 ]; then
  echo -e "\n${GREEN}[ AUR ] Installing missing packages:${RESET}"
  printf ' - %s\n' "${AUR_MISSING_PKGS[@]}"
  echo ""

  yay -S --needed --noconfirm "${AUR_MISSING_PKGS[@]}"
else
  echo -e "\n${GREEN}[ AUR ] All AUR packages are already installed${RESET}"
fi

pipx install terminaltexteffects # terminal effects for the screensaver
