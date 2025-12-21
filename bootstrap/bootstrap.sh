#!/usr/bin/env bash
BLUE="\033[34m"
GREEN="\033[32m"
RESET="\033[0m"

# Saves the direction of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure system time is correct (required for SSL / git / AUR)
sudo timedatectl set-ntp true

echo ""
echo -e "${BLUE}=====================================${RESET}"
echo -e "${GREEN}[ SYSTEM ] Installing infrastructure${RESET}"
echo -e "${BLUE}=====================================${RESET}"
echo ""

# SYSTEM - core infrastructure
SYSTEM_PKGS=(
  networkmanager                # network connectivity
  pipewire                      # audio/video engine
  wireplumber                   # audio session manager
  xdg-desktop-portal            # apps ↔ system bridge
  xdg-desktop-portal-hyprland   # Wayland portal (Hyprland)
  which                         # command locator (diagnostics)
  base-devel                    # build tools (yay)
  git                           # clone PKGBUILDs
  docker                        # container engine
  docker-compose                # compose support
  ttf-nerd-fonts-symbols        # symbols render
  btop                          # resource monitor
  wiremix                       # TUI audio mixer
)

sudo pacman -S --needed --noconfirm "${SYSTEM_PKGS[@]}"

echo ""
echo -e "${BLUE}==========================${RESET}"
echo -e "${GREEN}[ SYSTEM ] Installing yay${RESET}"
echo -e "${BLUE}==========================${RESET}"
echo ""
if ! command -v yay >/dev/null 2>&1; then
  echo "[ AUR ] Installing yay..."

  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay || exit 1
  makepkg -si --noconfirm
  cd -
fi

[ -d /tmp/yay ] && rm -rf /tmp/yay

echo ""
echo -e "${BLUE}=========================================${RESET}"
echo -e "${GREEN}[ APPS ] Installing essential user tools${RESET}"
echo -e "${BLUE}=========================================${RESET}"
echo ""

# APPS - essential user tools from pacman
APPS_PKGS=(
  alacritty           # terminal emulator
  nvim                # text editor, obviously
  tmux                # terminal multiplexor
  dbeaver             # database tool
  nautilus            # file manager
  wl-clipboard        # clipboard (Wayland)
  hyprshot            # screenshot utility
  ly                  # login manager
)

sudo pacman -S --needed --noconfirm "${APPS_PKGS[@]}"

# APPS - essential user tools from AUR
AUR_APPS_PKGS=(
  lazydocker          # terminal UI for managing Docker containers
  walker              # app launcher
  brave-bin           # web browser
  postman-bin         # testing APIs
)

yay -S --needed --noconfirm "${AUR_APPS_PKGS[@]}"

echo ""
echo -e "${BLUE}=================================${RESET}"
echo -e "${GREEN}[ UX ] Installing desktop layer ${RESET}"
echo -e "${BLUE}=================================${RESET}"
echo ""

# UX - visible desktop layer
UX_PKGS=(
  waybar                # status bar
  mako                  # notification daemon
  swaybg                # wallpaper manager
)

sudo pacman -S --needed --noconfirm "${UX_PKGS[@]}"

# Create the symlink for the configs & themes
bash "$SCRIPT_DIR/link.sh"

# Enables needed for the system to work
bash "$SCRIPT_DIR/enable.sh"

echo ""
echo -e "${BLUE}===================================${RESET}"
echo -e "${GREEN}Reboot the system to apply changes${RESET}"
echo -e "${BLUE}===================================${RESET}"
echo ""
