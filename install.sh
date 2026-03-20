#!/bin/bash
# Sanctum OS - One-Line Installer
# curl -fsSL https://raw.githubusercontent.com/John-Miltonian/sanctum-arch-rice/master/install.sh | bash

set -e

REPO_URL="https://github.com/John-Miltonian/sanctum-arch-rice"
INSTALL_DIR="$HOME/.local/share/sanctum-arch-rice"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║             ✠ SANCTUM OS - ONE-LINE INSTALLER ✠            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if running on Arch Linux
if ! command -v pacman &>/dev/null; then
    echo "✗ Error: This installer is designed for Arch Linux only."
    echo "  Please install the rice manually on your distribution."
    exit 1
fi

# Check for git
if ! command -v git &>/dev/null; then
    echo "Installing git..."
    sudo pacman -S --needed --noconfirm git
fi

# Clone or update repository
if [[ -d "$INSTALL_DIR" ]]; then
    echo "→ Updating existing installation..."
    cd "$INSTALL_DIR" && git pull
else
    echo "→ Cloning Sanctum OS repository..."
    mkdir -p "$INSTALL_DIR"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Run setup
echo "→ Running setup..."
cd "$INSTALL_DIR"
./setup.sh

echo ""
echo "✓ Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Add wallpaper: ~/.config/wallpapers/sanctum-dark.jpg"
echo "  2. Start Niri: niri"
echo ""
echo "Repository: $REPO_URL"
