CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

# Create config folder
mkdir -p "$CONFIG_DIR"

# Hyprland
ln -sfn "$DOTFILES_DIR/config/hypr" "$CONFIG_DIR/hypr"

# Theme system
mkdir -p "$CONFIG_DIR/theme/current"
ln -sfn "$CONFIG_DIR/theme/default" "$CONFIG_DIR/theme/current"
