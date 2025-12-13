# SYSTEM - core infrastructure
SYSTEM_PKGS=(
  networkmanager                # network connectivity
  pipewire                      # audio/video engine
  wireplumber                   # audio session manager
  xdg-desktop-portal            # apps ↔ system bridge
  xdg-desktop-portal-hyprland   # Wayland portal (Hyprland()
  )

echo "Installing system pkgs..."
sudo pacman -S --needed --noconfirm "${SYSTEM_PKGS[@]}"

# APPS - core user tools
APPS_PKGS=(
  brave-bin           # web browser
  alacritty           # terminal emulator
  nvim                # text editor, obviously
  tmux                # terminal multiplexor
  )

echo "Installing user tools..."
sudo pacman -S --needed --noconfirm "${APPS_PKGS[@]}"

# UX - visible desktop layer
UX_PKGS=(
  waybar                # status bar
  mako                  # notification daemon
  swaybg                # wallpaper manager
  wl-clipboard          # clipboard (Wayland)
  )

echo "Installing desktop layer tools..."
sudo pacman -S --needed --noconfirm "${UX_PKGS[@]}"
