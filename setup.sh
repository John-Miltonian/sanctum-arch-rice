#!/bin/bash
# Sanctum OS Setup Script
# Installs Niri rice with dark mode and Christian tools

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
LOCAL_BIN="$HOME/.local/bin"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║             ✠ SANCTUM OS - DARK CHRISTIAN RICE ✠           ║"
echo "║                                                            ║"
echo "║  A dark mode Arch Linux rice with Christian theming       ║"
echo "║  featuring Niri, transparency, and liturgical colors      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check dependencies
check_dependencies() {
    echo "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command -v niri &>/dev/null; then
        missing_deps+=("niri")
    fi
    
    if ! command -v waybar &>/dev/null; then
        missing_deps+=("waybar")
    fi
    
    if ! command -v kitty &>/dev/null; then
        missing_deps+=("kitty")
    fi
    
    if ! command -v wofi &>/dev/null; then
        missing_deps+=("wofi")
    fi
    
    if ! command -v swaylock &>/dev/null; then
        missing_deps+=("swaylock-effects")
    fi
    
    if ! command -v swaybg &>/dev/null; then
        missing_deps+=("swaybg")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo ""
        echo "Missing dependencies: ${missing_deps[*]}"
        echo ""
        echo "Install with:"
        echo "  sudo pacman -S niri waybar kitty wofi swaybg"
        echo "  yay -S swaylock-effects wlogout"
        echo ""
        read -p "Install missing dependencies now? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Installing dependencies..."
            sudo pacman -S --needed niri waybar kitty wofi swaybg 2>/dev/null || true
            yay -S --needed swaylock-effects wlogout 2>/dev/null || true
        fi
    else
        echo "✓ All dependencies found"
    fi
}

# Backup existing configs
backup_configs() {
    echo ""
    echo "Backing up existing configurations..."
    
    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    local configs=("niri" "waybar" "kitty" "wofi" "wlogout" "swaylock")
    
    for config in "${configs[@]}"; do
        if [[ -d "$CONFIG_DIR/$config" ]]; then
            echo "  Backing up $config..."
            cp -r "$CONFIG_DIR/$config" "$backup_dir/"
        fi
    done
    
    if [[ -f "$CONFIG_DIR/zsh/cross-prompt.zsh" ]]; then
        echo "  Backing up cross-prompt.zsh..."
        mkdir -p "$backup_dir/zsh"
        cp "$CONFIG_DIR/zsh/cross-prompt.zsh" "$backup_dir/zsh/"
    fi
    
    echo "✓ Backups saved to: $backup_dir"
}

# Copy configurations
install_configs() {
    echo ""
    echo "Installing configurations..."
    
    # Create directories
    mkdir -p "$CONFIG_DIR/niri"
    mkdir -p "$CONFIG_DIR/waybar"
    mkdir -p "$CONFIG_DIR/kitty"
    mkdir -p "$CONFIG_DIR/wofi"
    mkdir -p "$CONFIG_DIR/wlogout"
    mkdir -p "$CONFIG_DIR/swaylock"
    mkdir -p "$CONFIG_DIR/zsh"
    mkdir -p "$CONFIG_DIR/wallpapers"
    mkdir -p "$LOCAL_BIN"
    
    # Copy configs
    echo "  Installing Niri config..."
    cp "$SCRIPT_DIR/config/niri/config.kdl" "$CONFIG_DIR/niri/"
    
    echo "  Installing Waybar config..."
    cp "$SCRIPT_DIR/config/waybar/config" "$CONFIG_DIR/waybar/"
    cp "$SCRIPT_DIR/config/waybar/style.css" "$CONFIG_DIR/waybar/"
    
    echo "  Installing Kitty config..."
    cp "$SCRIPT_DIR/config/kitty/kitty.conf" "$CONFIG_DIR/kitty/"
    cp "$SCRIPT_DIR/config/kitty/session.conf" "$CONFIG_DIR/kitty/"
    
    echo "  Installing Wofi config..."
    cp "$SCRIPT_DIR/config/wofi/style.css" "$CONFIG_DIR/wofi/"
    
    echo "  Installing Wlogout config..."
    cp "$SCRIPT_DIR/config/wlogout/layout" "$CONFIG_DIR/wlogout/"
    cp "$SCRIPT_DIR/config/wlogout/style.css" "$CONFIG_DIR/wlogout/"
    
    echo "  Installing Swaylock config..."
    cp "$SCRIPT_DIR/config/swaylock/config" "$CONFIG_DIR/swaylock/"
    
    echo "  Installing Zsh cross prompt..."
    cp "$SCRIPT_DIR/config/zsh/cross-prompt.zsh" "$CONFIG_DIR/zsh/"
    
    # Copy scripts
    echo "  Installing helper scripts..."
    cp "$SCRIPT_DIR/local/bin/liturgical-theme.sh" "$LOCAL_BIN/"
    cp "$SCRIPT_DIR/local/bin/fetch-wallpapers.sh" "$LOCAL_BIN/"
    chmod +x "$LOCAL_BIN/"*.sh
    
    echo "✓ Configurations installed"
}

# Install Christian tools
install_christian_tools() {
    echo ""
    echo "Installing Christian tools..."
    bash "$SCRIPT_DIR/install-christian-tools.sh"
}

# Update shell profile
update_shell() {
    echo ""
    echo "Updating shell configuration..."
    
    local shell_rc=""
    if [[ $SHELL == *"zsh"* ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ $SHELL == *"bash"* ]]; then
        shell_rc="$HOME/.bashrc"
    else
        shell_rc="$HOME/.bashrc"
    fi
    
    # Add cross prompt source
    local cross_prompt_line="source $CONFIG_DIR/zsh/cross-prompt.zsh"
    if ! grep -q "$cross_prompt_line" "$shell_rc" 2>/dev/null; then
        echo "" >> "$shell_rc"
        echo "# Sanctum OS - Christian Cross Prompt" >> "$shell_rc"
        echo "$cross_prompt_line" >> "$shell_rc"
        echo "✓ Added cross prompt to $shell_rc"
    else
        echo "✓ Cross prompt already configured"
    fi
    
    # Add local bin to PATH
    if ! grep -q "$LOCAL_BIN" "$shell_rc"; then
        echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >> "$shell_rc"
        echo "✓ Added ~/.local/bin to PATH"
    fi
}

# Set up fonts
setup_fonts() {
    echo ""
    echo "Font Setup"
    echo "----------"
    echo "Recommended fonts for Sanctum OS:"
    echo "  • Fira Code (monospace) - pacman -S ttf-fira-code"
    echo "  • Font Awesome (icons) - pacman -S ttf-font-awesome"
    echo "  • Noto Fonts (CJK support) - pacman -S noto-fonts"
    echo ""
    read -p "Install recommended fonts? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo pacman -S --needed ttf-fira-code ttf-font-awesome noto-fonts 2>/dev/null || true
        echo "✓ Fonts installed"
    fi
}

# Wallpaper setup
setup_wallpaper() {
    echo ""
    echo "Wallpaper Setup"
    echo "---------------"
    
    "$LOCAL_BIN/fetch-wallpapers.sh"
    
    echo ""
    echo "Note: You'll need to provide your own wallpaper."
    echo "Save as: ~/.config/wallpapers/sanctum-dark.jpg"
}

# Final instructions
show_instructions() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
echo "║                 ✠ SETUP COMPLETE ✠                         ║"
echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Next Steps:"
    echo "-----------"
    echo ""
    echo "1. Set your wallpaper:"
    echo "   Save a dark religious image to:"
    echo "   ~/.config/wallpapers/sanctum-dark.jpg"
    echo ""
    echo "2. Start Niri:"
    echo "   niri"
    echo ""
    echo "3. Keybindings:"
    echo "   Super+Enter    - Open terminal"
    echo "   Super+Space    - Open launcher"
    echo "   Super+B        - Open Bible CLI"
    echo "   Super+Shift+B  - Open BibleTime"
    echo "   Super+V        - Daily verse"
    echo "   Super+1-0      - Switch workspaces"
    echo "   Super+L        - Lock screen"
    echo ""
    echo "4. Change liturgical theme:"
    echo "   liturgical-theme.sh [advent|christmas|lent|easter|pentecost|ordinary]"
    echo ""
    echo "5. Installed Christian tools:"
    echo "   • kjv [reference]      - Read KJV Bible"
    echo "   • bible-cli            - TUI Bible reader"
    echo "   • daily-verse          - Daily verse in terminal"
    echo "   • grepbible [ref]      - Multi-language search"
    echo "   • random-verse         - Random verse widget"
    echo "   • christian-hours      - Prayer hours reminder"
    echo ""
    echo "6. For SDDM/Display Manager autostart:"
    echo "   Create: /usr/share/wayland-sessions/niri.desktop"
    echo "   Exec=niri"
    echo ""
    echo "✠ Pax et bonum ✠"
    echo ""
}

# Main
main() {
    check_dependencies
    backup_configs
    install_configs
    
    read -p "Install Christian Bible tools? [Y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        install_christian_tools
    fi
    
    update_shell
    setup_fonts
    setup_wallpaper
    show_instructions
}

main
