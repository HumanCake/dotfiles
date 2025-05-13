#!/bin/bash

set -e

# Get the directory of the script (absolute path)
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Define the dotfiles directory relative to the script
DOTFILES_DIR="$SCRIPT_DIR"

# Define the config directory where symlinks will go
CONFIG_DIR="$HOME/.config"

echo "🔗 Setting up nvim and kitty configs..."

# Create ~/.config if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Link nvim
if [ -e "$CONFIG_DIR/nvim" ] && [ ! -L "$CONFIG_DIR/nvim" ]; then
  echo "📦 Backing up existing nvim config..."
  mv "$CONFIG_DIR/nvim" "$CONFIG_DIR/nvim.backup"
fi
ln -sfn "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
echo "✅ Linked nvim → $DOTFILES_DIR/.config/nvim"

# Link kitty
if [ -e "$CONFIG_DIR/kitty" ] && [ ! -L "$CONFIG_DIR/kitty" ]; then
  echo "📦 Backing up existing kitty config..."
  mv "$CONFIG_DIR/kitty" "$CONFIG_DIR/kitty.backup"
fi
ln -sfn "$DOTFILES_DIR/.config/kitty" "$CONFIG_DIR/kitty"
echo "✅ Linked kitty → $DOTFILES_DIR/.config/kitty"

echo "🎉 Done."

