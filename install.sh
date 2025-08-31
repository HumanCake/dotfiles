#!/bin/bash

set -e

# Get the directory of the script (absolute path)
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Define the dotfiles directory relative to the script
DOTFILES_DIR="$SCRIPT_DIR"

# Define the config directory where symlinks will go
CONFIG_DIR="$HOME/.config"

echo "🔗 Setting up configs..."

# Create ~/.config if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Link nvim
if [ -e "$CONFIG_DIR/nvim" ] && [ ! -L "$CONFIG_DIR/nvim" ]; then
  echo "📦 Backing up existing nvim config..."
  mv "$CONFIG_DIR/nvim" "$CONFIG_DIR/nvim.backup"
fi
ln -sfn "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
echo "✅ Linked nvim → $DOTFILES_DIR/.config/nvim"

# Link ideavimrc (located in home directory)
if [ -e "$HOME/.ideavimrc" ] && [ ! -L "$HOME/.ideavimrc" ]; then
  echo "📦 Backing up existing ideavimrc..."
  mv "$HOME/.ideavimrc" "$HOME/.ideavimrc.backup"
fi
ln -sfn "$DOTFILES_DIR/.config/ideavim/.ideavimrc" "$HOME/.ideavimrc"
echo "✅ Linked .ideavimrc → $DOTFILES_DIR/.config/ideavim/.ideavimrc"

# Link WezTerm
if [ -e "$CONFIG_DIR/wezterm" ] && [ ! -L "$CONFIG_DIR/wezterm" ]; then
  echo "📦 Backing up existing wezterm config..."
  mv "$CONFIG_DIR/wezterm" "$CONFIG_DIR/wezterm.backup"
fi
ln -sfn "$DOTFILES_DIR/.config/wezterm" "$CONFIG_DIR/wezterm"
echo "✅ Linked wezterm → $DOTFILES_DIR/.config/wezterm"

echo "🎉 Done."

